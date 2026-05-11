---
name: app-core-integration
description: Integrate and consume shared capabilities from app_core in Flutter apps, including dependency injection setup (get_it + injectable), external package module wiring, service registration patterns, and usage of app_core contracts in features. Use this skill whenever the user mentions app_core, core module integration, DI setup, service registration, or asks to use anything from @app_core/—even if they only say "pakai core", "hubungkan ke app_core", or "inject service ini dari core".
---

# App Core Integration

Use this skill to integrate `@app_core/` safely and consistently into consumer apps.
Main goal: avoid ad-hoc wiring, keep DI deterministic, and use app_core contracts from feature code.

---

## Scope

This skill helps you:

- wire `app_core` into app DI lifecycle,
- consume `app_core` services/contracts from features,
- add new core-exposed dependencies in the right place,
- keep integration aligned with `injectable` + `get_it` patterns.

Prefer minimal changes that match the existing app structure.

---

## When to apply

Read this skill fully when user asks to:

- integrate or migrate to `app_core`,
- register services from core into app DI,
- use `HttpClient`, storage, notification, responsive, logging, etc. from core,
- add new dependency to `AppCoreModule`,
- debug "service not found" / locator injection errors involving core.

For tiny fixes, apply only relevant sections without architecture churn.

---

## app_core integration baseline

`app_core` exposes:

- domain/failure contracts,
- infrastructure service contracts + implementations,
- DI bootstrap (`configureDependencies`, `getIt`, micro package init),
- helpers like repository error handling.

In consumer app, treat `app_core` as foundational dependency. Feature modules consume contracts/services, not duplicate base infra setup.

---

## DI wiring flow (consumer app)

Use this order:

1. Add dependency to `pubspec.yaml` (`app_core`).
2. Ensure app has `injectable` + generated DI setup.
3. Initialize DI at app startup (`WidgetsFlutterBinding.ensureInitialized()` first if async setup needed).
4. Include `app_core` external package module in app injector config when using micro-package setup.
5. Run code generation after annotation/module changes.

If app calls `configureDependencies()` from `app_core` directly, keep one clear bootstrap path and avoid duplicate init calls.

---

## Service usage contract

In feature/repository layers:

- resolve dependencies from app injector (`getIt<T>()` or constructor injection),
- depend on core abstractions (e.g., `HttpClient`, `StorageService`, `LogService`) instead of direct third-party SDKs,
- return typed results/failures consistent with app_core patterns.

Do not instantiate `Dio`, `Hive`, `FirebaseMessaging`, or other infra clients directly in feature code when core already provides service boundaries.

---

## Adding new dependency to app_core

When new shared external dependency is needed:

1. Add service contract + implementation in `app_core` infrastructure layer.
2. Register external object or service in `app_core` DI module (`AppCoreModule` or annotated implementation).
3. Regenerate injectable files.
4. Export needed public entry points through `app_core.dart` if meant for consumers.
5. Update docs/examples so consumer apps know how to consume it.

Keep registrations centralized and documented.

---

## Error handling and result flow

When integrating repositories with core:

- prefer `Either`/typed failure flow over throwing raw exceptions,
- use shared failure classes from `app_core`,
- use repository error handler/helper when available for consistent crash + user error treatment.

UI/state should receive stable failure signals and decide user-facing behavior.

---

## Startup sequence guidance

Typical safe startup sequence:

1. initialize Flutter bindings,
2. initialize time-sensitive dependencies (timezone/notifications if needed),
3. configure DI (app + core modules),
4. initialize core services that require startup calls,
5. run app.

Avoid lazy runtime initialization deep inside widgets for core services that should be ready at boot.

---

## Output format for core-integration tasks

## 1) Integration target
- what core capability is being wired from `@app_core/`

## 2) DI setup changes
- injector/module/bootstrap changes needed

## 3) Usage points
- where features/repositories consume the injected service

## 4) Error/result handling
- how failures are mapped and propagated

## 5) Verification checklist
- generation, runtime resolution, and smoke test steps

Keep recommendations concrete and tied to current app structure.

---

## Common pitfalls to avoid

- Initializing DI twice with conflicting bootstrap paths.
- Mixing constructor injection and manual `getIt` lookups inconsistently in same layer without reason.
- Registering services in consumer app that already belong in `app_core`.
- Forgetting to run code generation after DI/module changes.
- Importing deep internal files from `app_core/src/...` in consumer app when public exports exist.

---

## Quick checklist

- [ ] `app_core` dependency and imports use package-level entry points where possible.
- [ ] DI bootstrap includes core module(s) exactly once.
- [ ] Required services resolve successfully from injector at runtime.
- [ ] Feature code consumes core contracts, not raw infra SDK instances.
- [ ] Result/failure handling follows app_core conventions.
