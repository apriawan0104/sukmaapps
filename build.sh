#!/usr/bin/env bash
# Build Flutter app(s) and upload to Firebase App Distribution.
# Usage:
#   chmod +x build.sh
#   ./build.sh
#   or
#   ./build.sh --flavor dev --os android
#   ./build.sh --flavor uat --os both --notes "QA build"
#   ./build.sh --flavor prd --os ios --skip-upload
#
# Customize App IDs / tester groups:
#   1) edit CONFIG section below, or
#   2) export env vars (ANDROID_APP_ID_DEV, TESTER_GROUPS_UAT, ...), or
#   3) create build.config.local.sh (gitignored) and override there.

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

# ---------------------------------------------------------------------------
# CONFIG — customize per flavor (env / build.config.local.sh override these)
# ---------------------------------------------------------------------------

# Android Firebase App IDs (from google-services.json package mapping)
ANDROID_APP_ID_DEV="${ANDROID_APP_ID_DEV:-1:933792903721:android:b46611665fc39456fda238}"
ANDROID_APP_ID_UAT="${ANDROID_APP_ID_UAT:-1:933792903721:android:970ae9e38408aa54fda238}"
ANDROID_APP_ID_PRD="${ANDROID_APP_ID_PRD:-1:933792903721:android:12a9a824697d8e9bfda238}"

# iOS Firebase App IDs — replace with real IDs from Firebase Console
IOS_APP_ID_DEV="1:933792903721:ios:30e92f9abe8a35b2fda238"
IOS_APP_ID_UAT="1:933792903721:ios:e63678e5bf69155efda238"
IOS_APP_ID_PRD="1:933792903721:ios:60afc8324f825c40fda238"

# Firebase App Distribution tester groups (comma-separated allowed)
TESTER_GROUPS_DEV="hardlogicom"
TESTER_GROUPS_UAT="hardlogicom"
TESTER_GROUPS_PRD="hardlogicom,sukma"

# Active Firebase CLI account (must already be logged in via `firebase login:add`)
FIREBASE_ACCOUNT="${FIREBASE_ACCOUNT:-sukmaconvertpulsa@gmail.com}"

# Entrypoints
TARGET_DEV="${TARGET_DEV:-lib/main_dev.dart}"
TARGET_UAT="${TARGET_UAT:-lib/main_uat.dart}"
TARGET_PRD="${TARGET_PRD:-lib/main.dart}"

# Build mode: debug | profile | release
BUILD_MODE_DEV="${BUILD_MODE_DEV:-profile}"
BUILD_MODE_UAT="${BUILD_MODE_UAT:-profile}"
BUILD_MODE_PRD="${BUILD_MODE_PRD:-release}"

# iOS export method: development | ad-hoc | app-store | enterprise
IOS_EXPORT_DEV="${IOS_EXPORT_DEV:-development}"
IOS_EXPORT_UAT="${IOS_EXPORT_UAT:-development}"
IOS_EXPORT_PRD="${IOS_EXPORT_PRD:-development}"

# Android build flags
ANDROID_TARGET_PLATFORM="${ANDROID_TARGET_PLATFORM:-android-arm64}"
ANDROID_SPLIT_PER_ABI="${ANDROID_SPLIT_PER_ABI:-true}"

# Optional local overrides (not committed)
if [[ -f "$ROOT_DIR/build.config.local.sh" ]]; then
  # shellcheck disable=SC1091
  source "$ROOT_DIR/build.config.local.sh"
fi

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

log()  { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32m✓\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m✗\033[0m %s\n' "$*" >&2; exit 1; }

upper() { printf '%s' "$1" | tr '[:lower:]' '[:upper:]'; }

# resolve_config PREFIX flavor → expands e.g. ANDROID_APP_ID + dev → $ANDROID_APP_ID_DEV
resolve_config() {
  local prefix="$1" flavor="$2"
  local key="${prefix}_$(upper "$flavor")"
  eval "printf '%s' \"\${$key-}\""
}

flutter_bin() {
  if [[ -d "$ROOT_DIR/.fvm" ]] && command -v fvm >/dev/null 2>&1; then
    fvm flutter "$@"
  else
    command flutter "$@"
  fi
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing command: $1"
}

prompt_choice() {
  # prompt_choice "Title" var_name option1 option2 ...
  local title="$1" varname="$2"
  shift 2
  local options=("$@")
  local i=1 choice
  echo ""
  echo "$title"
  for opt in "${options[@]}"; do
    echo "  $i) $opt"
    i=$((i + 1))
  done
  while true; do
    read -r -p "Pilih [1-${#options[@]}]: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      eval "$varname='${options[$((choice - 1))]}'"
      return
    fi
    echo "Pilihan tidak valid."
  done
}

remove_pubspec_lock() {
  if [[ -f pubspec.lock ]]; then
    rm -f pubspec.lock
    ok "Removed pubspec.lock"
  else
    warn "pubspec.lock not found (skip)"
  fi
}

# ---------------------------------------------------------------------------
# Args
# ---------------------------------------------------------------------------

FLAVOR=""
OS=""
RELEASE_NOTES=""
SKIP_UPLOAD=false
SKIP_CLEAN=false

usage() {
  cat <<'EOF'
Usage: ./build.sh [options]

Options:
  --flavor <dev|uat|prd>     Flavor to build
  --os <ios|android|both>    Target platform(s)
  --notes <text>             Firebase release notes
  --skip-upload              Build only, skip Firebase upload
  --skip-clean               Skip flutter clean (faster iteration)
  -h, --help                 Show help

Interactive prompts are used for any missing required option.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --flavor) FLAVOR="${2:-}"; shift 2 ;;
    --os) OS="${2:-}"; shift 2 ;;
    --notes) RELEASE_NOTES="${2:-}"; shift 2 ;;
    --skip-upload) SKIP_UPLOAD=true; shift ;;
    --skip-clean) SKIP_CLEAN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) die "Unknown argument: $1 (see --help)" ;;
  esac
done

# ---------------------------------------------------------------------------
# Interactive selection
# ---------------------------------------------------------------------------

if [[ -z "$FLAVOR" ]]; then
  prompt_choice "1) Pilih flavor yang akan di-build:" FLAVOR dev uat prd
fi
case "$FLAVOR" in
  dev|uat|prd) ;;
  *) die "Invalid flavor: $FLAVOR (use dev|uat|prd)" ;;
esac

if [[ -z "$OS" ]]; then
  prompt_choice "2) Pilih OS yang akan di-build:" OS ios android "ios dan android"
fi
case "$OS" in
  ios|android) ;;
  "ios dan android"|both|all) OS="both" ;;
  *) die "Invalid OS: $OS (use ios|android|both)" ;;
esac

if [[ -z "$RELEASE_NOTES" ]]; then
  echo ""
  echo "3) Isi release notes:"
  DEFAULT_NOTES="$(git log -1 --pretty=%s 2>/dev/null || echo "Build $FLAVOR")"
  while true; do
    read -r -p "   Release notes [${DEFAULT_NOTES}]: " RELEASE_NOTES
    RELEASE_NOTES="${RELEASE_NOTES:-$DEFAULT_NOTES}"
    # trim whitespace
    RELEASE_NOTES="$(printf '%s' "$RELEASE_NOTES" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
    [[ -n "$RELEASE_NOTES" ]] && break
    echo "   Release notes wajib diisi."
  done
fi

TARGET="$(resolve_config TARGET "$FLAVOR")"
BUILD_MODE="$(resolve_config BUILD_MODE "$FLAVOR")"
IOS_EXPORT="$(resolve_config IOS_EXPORT "$FLAVOR")"
ANDROID_APP_ID="$(resolve_config ANDROID_APP_ID "$FLAVOR")"
IOS_APP_ID="$(resolve_config IOS_APP_ID "$FLAVOR")"
TESTER_GROUPS="$(resolve_config TESTER_GROUPS "$FLAVOR")"

[[ -n "$TARGET" ]] || die "Missing TARGET for flavor $FLAVOR"
[[ -f "$TARGET" ]] || die "Entrypoint not found: $TARGET"

MODE_FLAG="--${BUILD_MODE}"

echo ""
echo "──────── Summary ────────"
echo "  Flavor        : $FLAVOR"
echo "  OS            : $OS"
echo "  Target        : $TARGET"
echo "  Build mode    : $BUILD_MODE"
echo "  iOS export    : $IOS_EXPORT"
echo "  Tester groups : $TESTER_GROUPS"
echo "  Firebase acct : ${FIREBASE_ACCOUNT:-"(current login)"}"
echo "  Notes         : $RELEASE_NOTES"
echo "  Upload        : $([[ "$SKIP_UPLOAD" == true ]] && echo no || echo yes)"
echo "─────────────────────────"
read -r -p "4) Lanjut proses build? [Y/n]: " CONFIRM
CONFIRM="${CONFIRM:-Y}"
[[ "$CONFIRM" =~ ^[Yy]$ ]] || die "Dibatalkan."

require_cmd firebase
if [[ "$OS" == "ios" || "$OS" == "both" ]]; then
  [[ "$(uname -s)" == "Darwin" ]] || die "iOS build hanya tersedia di macOS"
fi

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------

log "remove_pubspec_lock"
remove_pubspec_lock

if [[ "$SKIP_CLEAN" == true ]]; then
  warn "Skip flutter clean (--skip-clean)"
  log "flutter pub get"
  flutter_bin pub get
else
  log "flutter clean && flutter pub get"
  flutter_bin clean
  flutter_bin pub get
fi

IPA_PATH=""
APK_PATH=""

build_ios() {
  log "Build iOS IPA (flavor=$FLAVOR, mode=$BUILD_MODE, export=$IOS_EXPORT)"
  flutter_bin build ipa \
    -t "$TARGET" \
    --flavor "$FLAVOR" \
    "$MODE_FLAG" \
    --export-method "$IOS_EXPORT"

  IPA_PATH="$(find build/ios/ipa -name '*.ipa' -type f 2>/dev/null | head -n 1 || true)"
  [[ -n "$IPA_PATH" && -f "$IPA_PATH" ]] || die "IPA not found under build/ios/ipa"
  ok "IPA: $IPA_PATH"
}

build_android() {
  log "Build Android APK (flavor=$FLAVOR, mode=$BUILD_MODE)"
  local split_args=()
  if [[ "$ANDROID_SPLIT_PER_ABI" == "true" ]]; then
    split_args+=(--split-per-abi)
  fi

  flutter_bin build apk \
    -t "$TARGET" \
    --flavor "$FLAVOR" \
    "$MODE_FLAG" \
    --target-platform "$ANDROID_TARGET_PLATFORM" \
    "${split_args[@]}"

  # Prefer arm64 when split-per-abi is used
  APK_PATH="$(find build/app/outputs/flutter-apk -name "*-${FLAVOR}-${BUILD_MODE}-arm64-v8a.apk" -type f 2>/dev/null | head -n 1 || true)"
  if [[ -z "$APK_PATH" ]]; then
    APK_PATH="$(find build/app/outputs/flutter-apk -name "*-${FLAVOR}-${BUILD_MODE}*.apk" ! -name '*.sha1' -type f 2>/dev/null | head -n 1 || true)"
  fi
  [[ -n "$APK_PATH" && -f "$APK_PATH" ]] || die "APK not found under build/app/outputs/flutter-apk"
  ok "APK: $APK_PATH"
}

case "$OS" in
  ios) build_ios ;;
  android) build_android ;;
  both) build_ios; build_android ;;
esac

# ---------------------------------------------------------------------------
# Firebase App Distribution
# ---------------------------------------------------------------------------

current_firebase_account() {
  # Parses: "Logged in as you@example.com"
  firebase login:list 2>/dev/null | sed -n 's/^Logged in as //p' | head -n 1
}

use_firebase_account() {
  [[ -n "$FIREBASE_ACCOUNT" ]] || return 0

  local current
  current="$(current_firebase_account || true)"

  if [[ "$current" == "$FIREBASE_ACCOUNT" ]]; then
    ok "Already using Firebase account: $FIREBASE_ACCOUNT"
    return 0
  fi

  log "Switch Firebase account → $FIREBASE_ACCOUNT (current: ${current:-none})"
  firebase login:use "$FIREBASE_ACCOUNT"

  current="$(current_firebase_account || true)"
  if [[ "$current" != "$FIREBASE_ACCOUNT" ]]; then
    die "Firebase account mismatch. Expected '$FIREBASE_ACCOUNT', got '${current:-none}'. Run: firebase login:add $FIREBASE_ACCOUNT"
  fi
  ok "Using Firebase account: $FIREBASE_ACCOUNT"
}

upload_artifact() {
  local platform="$1" file="$2" app_id="$3"
  [[ -f "$file" ]] || die "Artifact missing: $file"
  if [[ "$app_id" == REPLACE_WITH_* || -z "$app_id" ]]; then
    die "Set ${platform} Firebase App ID for flavor '$FLAVOR' (edit build.sh CONFIG or build.config.local.sh)"
  fi

  log "Upload $platform → Firebase App Distribution"
  echo "  app      : $app_id"
  echo "  groups   : $TESTER_GROUPS"
  echo "  file     : $file"

  firebase appdistribution:distribute "$file" \
    --app "$app_id" \
    --groups "$TESTER_GROUPS" \
    --release-notes "$RELEASE_NOTES"

  ok "Uploaded $platform ($FLAVOR)"
}

if [[ "$SKIP_UPLOAD" == true ]]; then
  warn "Skip upload (--skip-upload)"
else
  use_firebase_account
  case "$OS" in
    ios) upload_artifact ios "$IPA_PATH" "$IOS_APP_ID" ;;
    android) upload_artifact android "$APK_PATH" "$ANDROID_APP_ID" ;;
    both)
      upload_artifact ios "$IPA_PATH" "$IOS_APP_ID"
      upload_artifact android "$APK_PATH" "$ANDROID_APP_ID"
      ;;
  esac
fi

echo ""
ok "Done."
