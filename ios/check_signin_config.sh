#!/bin/bash
# Verifies the native config that Google/Apple Sign In depend on:
#  - every Runner build configuration resolves FIREBASE_REVERSED to the REVERSED_CLIENT_ID
#    of the GoogleService-Info.plist that the same configuration's bundle id will receive
#  - Runner.entitlements is wired up and declares Sign in with Apple
# Run from the ios/ directory: ./check_signin_config.sh
set -u
cd "$(dirname "$0")"

status=0
fail() { echo "FAIL: $*"; status=1; }

for config in Debug Release Profile \
  Debug-dev Debug-uat Debug-prd \
  Release-dev Release-uat Release-prd \
  Profile-dev Profile-uat Profile-prd; do

  settings=$(xcodebuild -project Runner.xcodeproj -target Runner \
    -configuration "$config" -showBuildSettings 2>/dev/null)

  reversed=$(echo "$settings" | awk -F' = ' '/^ *FIREBASE_REVERSED = /{print $2}')
  entitlements=$(echo "$settings" | awk -F' = ' '/^ *CODE_SIGN_ENTITLEMENTS = /{print $2}')

  # Mirrors the "Copy GoogleService-info.plist" build phase: the flavor is the suffix after
  # the last dash, and the unflavored configs fall back to prd.
  flavor=prd
  [[ $config =~ -([^-]*)$ ]] && flavor="${BASH_REMATCH[1]}"
  expected=$(/usr/libexec/PlistBuddy -c "Print :REVERSED_CLIENT_ID" \
    "config/$flavor/GoogleService-Info.plist" 2>/dev/null)

  [ "$reversed" = "$expected" ] || fail "$config: FIREBASE_REVERSED is '$reversed', config/$flavor expects '$expected'"
  [ -n "$entitlements" ] || fail "$config: CODE_SIGN_ENTITLEMENTS is not set"
done

/usr/libexec/PlistBuddy -c "Print :com.apple.developer.applesignin" Runner/Runner.entitlements >/dev/null 2>&1 \
  || fail "Runner.entitlements is missing com.apple.developer.applesignin"

grep -q 'FIREBASE_REVERSED' Runner/Info.plist \
  || fail "Info.plist does not register \$(FIREBASE_REVERSED) as a URL scheme"

[ $status -eq 0 ] && echo "OK: sign-in config is consistent across all flavors"
exit $status
