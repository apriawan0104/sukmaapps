---
name: flutter-flavor
description: Set up and maintain Flutter flavors end-to-end (Android, iOS, entrypoints, build/run commands, and environment config) with consistent naming and low-risk rollout. Use this skill whenever the user mentions flavor, environment (dev/uat/prod), app variants, bundle id, app name per env, Firebase config per env, --flavor, --dart-define, or asks to separate configuration by deployment stage—even if they only say "buat env dev", "pisah prod", or "kenapa flavor gagal build".
---

# Flutter Flavor Setup

Use this skill when a project needs multiple environments with predictable builds.
Goal: one source of truth per environment, no hidden config drift.

---

## Scope

This skill helps you:

- define flavor strategy (`dev`, `uat`, `prd` or project-specific variants),
- wire Android + iOS flavor setup consistently,
- align entrypoints and runtime env config,
- standardize run/build commands and CI-friendly usage.

Prefer incremental changes over big-bang rewrites.

---

## When to apply

Use this skill for:

- adding flavors to a non-flavored app,
- fixing broken flavor build/run behavior,
- splitting API keys/base URLs by environment,
- aligning app id/app name/signing/firebase per env,
- cleaning mixed `--flavor` + `--dart-define` usage.

If task is tiny (single build fix), still validate the full flavor chain briefly.

---

## Flavor contract (recommended)

Define flavor as a deployment target, not just a random string.

For this workspace, default naming can follow existing launch config:

- `dev`
- `uat`
- `prd`

Keep names consistent across:

- Android product flavors,
- iOS schemes/configs,
- Flutter run/build commands,
- entrypoint naming and env loaders.

---

## End-to-end architecture

Treat flavors as one pipeline:

1. **Build-time selector**: `--flavor <name>`
2. **Runtime config**: `--dart-define` and/or env file loader
3. **Entrypoint**: `lib/main_<flavor>.dart` (optional but recommended)
4. **Platform config**:
   - Android: `flavorDimensions` + `productFlavors`
   - iOS: scheme + build configuration mapping
5. **Service init**: Firebase, API base URL, analytics keys, etc.

Do not rely on only one layer (e.g., only launch.json) and assume flavor is complete.

---

## Android checklist

- Declare one `flavorDimensions` (e.g., `"env"`) unless multiple are truly needed.
- Add `productFlavors` for each env with explicit values:
  - `applicationIdSuffix` (non-prod),
  - `resValue`/manifest placeholders for app name,
  - env-specific constants if needed.
- Ensure signing/build type compatibility (`debug/release` + each flavor).
- Verify build variants are generated as expected.

Keep gradle config readable; avoid flavor logic duplication in many files.

---

## iOS checklist

- Create scheme per flavor (`dev`, `uat`, `prd`) or equivalent naming.
- Map each scheme to correct build configuration (`Debug-Dev`, `Release-Prod`, etc.).
- Keep bundle id/display name consistent with flavor intent.
- If Firebase is used, ensure correct plist per scheme/config.

Always verify scheme selection in Xcode + CLI build.

---

## Entrypoints and app config

Recommended pattern:

- `lib/main.dart` as shared bootstrap or prod default,
- `lib/main_dev.dart`, `lib/main_uat.dart`, `lib/main_prd.dart` for explicit env bootstraps.

Each entrypoint should only orchestrate config differences (flavor/env init), not duplicate app code.

Centralize env values in one configuration layer, then inject to DI/services.

---

## Runtime env with flutter_dotenv

If project uses `flutter_dotenv`, make mapping explicit and deterministic:

- `.env.dev` -> `main_dev.dart`
- `.env.uat` -> `main_uat.dart`
- `.env.prd` (or `.env.prod`) -> `main_prd.dart` / `main.dart`

Recommended entrypoint pattern:

1. choose env file based on target flavor,
2. load dotenv before app bootstrap,
3. pass resolved config into app DI layer.

Keep dotenv usage centralized (config service/class), not scattered in feature code.

### Security note for dotenv

Treat dotenv values in mobile as **non-secret runtime config**:

- acceptable: base URL, public API identifiers, feature flags,
- not acceptable: private keys, master secrets, server credentials.

Assume client-side values can be extracted from app binaries/logs.
For sensitive secrets, keep them on backend and expose only controlled tokens/flows to the app.

---

## Commands standardization

Define canonical commands and keep them in docs/CI:

- run dev: `flutter run --flavor dev -t lib/main_dev.dart`
- run uat: `flutter run --flavor uat -t lib/main_uat.dart`
- run prd: `flutter run --flavor prd -t lib/main.dart` (or `main_prd.dart`)

- build apk/aab/ipa must mirror same flavor + target pattern.

If app also uses `--dart-define`, make required keys explicit and versioned.

---

## Integration with core modules

When using shared core package (e.g., `app_core`):

- keep flavor-driven config (base URL, feature flags, API keys) in app-level config layer,
- inject resolved config via DI during startup,
- avoid hardcoded env values inside repositories/services.

This keeps `app_core` reusable while app decides environment details.

---

## Debugging flavor failures

Diagnose in this order:

1. command (`--flavor` + target entrypoint),
2. platform flavor/scheme existence,
3. bundle id/application id mapping,
4. env config loaded at runtime,
5. service init (Firebase/API keys) for selected flavor.

Most failures come from naming mismatch across these layers.

---

## Output format for flavor tasks

## 1) Current state
- what flavor pieces already exist vs missing

## 2) Proposed flavor matrix
- env names, entrypoints, app id/name mapping

## 3) Platform updates
- Android + iOS concrete changes

## 4) Runtime config strategy
- `--dart-define`, env classes/files, DI injection

## 5) Verification
- exact run/build commands and smoke checks

Keep output practical; avoid abstract architecture-only advice.

---

## Anti-patterns to avoid

- Flavor names differ across Android/iOS/CLI.
- Per-env secrets hardcoded in source.
- Launch config has flavor args but platform is not configured.
- App logic duplicated fully in each `main_<flavor>.dart`.
- CI builds only one flavor while others silently rot.

---

## Quick checklist

- [ ] Flavor names are consistent (`dev/uat/prd` or agreed variant).
- [ ] Android product flavors and iOS schemes both configured.
- [ ] Entrypoints and commands map 1:1 to flavors.
- [ ] Runtime env values flow through config + DI cleanly.
- [ ] Each flavor can run/build successfully with documented commands.
