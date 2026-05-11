---
name: flutter-testing
description: Add, review, and debug Flutter automated tests at three levels—unit (pure Dart logic), widget (testWidgets, finders, gestures), and integration (integration_test on device/emulator, full app drive). Use this skill whenever the user mentions unit tests, widget tests, integration tests, E2E, golden tests, pumpWidget, testWidgets, IntegrationTestWidgetsFlutterBinding, mock/fake, test coverage, flaky tests, or asks to "test this screen" or "add tests" to Flutter code—even if they only say "bikin test", "widget_test pecah", or "integration gimana jalaninnya."
---

# Flutter testing (unit, widget, integration)

This skill orients you toward **tests that are reliable in CI and fast to run locally** by picking the right layer, keeping I/O and time deterministic, and matching the project’s state/DI setup.

Read this skill fully when: adding a new test file, debugging a red test, setting up `integration_test/`, or choosing between mocking vs. faking dependencies.

---

## How the three layers differ

| Layer | Runs on | Best for | Typical location |
|--------|---------|----------|------------------|
| **Unit** | VM only (no real UI) | Pure functions, mappers, validators, small notifiers without platform | `test/…_test.dart` (or `test/unit/…`) |
| **Widget** | Test binding + fake screen | One widget/screen, taps, finders, navigation within `MaterialApp` | `test/…_test.dart` or `test/widget/…` |
| **Integration** | Device/emulator/simulator | Real plugins, full app, multi-screen flows, platform channels | `integration_test/…_test.dart` |

**Why three layers:** Unit tests are cheapest and most precise. Widget tests catch layout and interaction bugs without devices. Integration tests cost the most and prove end-to-end behavior; use them for flows you cannot credibly fake (plugins, real navigation stack, OS integration).

**Default bias:** Reach for **unit** for logic, **widget** for UI, and add **integration** when the risk is *outside* the widget tree (plugins, real async OS behavior).

---

## One package root, one `flutter test` invocation

- App package: `test/` and `integration_test/` live next to `lib/`.
- Inner packages (e.g. `app_core/`): run tests **from that package’s directory** so imports and `package:` names resolve.
- **Never** mix integration driver setup inside a normal `test/` file that should run on the host VM only; integration entrypoints use `integration_test`’s binding (see below).

---

## Unit tests

**Use for:** `DateFormat`, parsing, domain rules, `Result`-style types, reducers, pure `Notifier` methods that do not need `BuildContext` or `PlatformChannel`.

**Stack:** `package:test` or `package:flutter_test` (either works for non-widget unit tests; many Flutter repos use `flutter_test` for one runner).

**Practices:**

- **No** `WidgetsFlutterBinding` unless you are about to use widget APIs; keep unit files free of `pumpWidget` to keep them fast.
- Prefer **fakes** (hand-written implementations) over heavy mocks when behavior is simple; use **mocktail** / **mockito** if the project already does.
- **Time:** inject `Clock` or pass `DateTime` in; for periodic timers use `FakeAsync` or the project’s test clock.
- **Random:** inject a `Random` with a fixed seed in tests.
- **Async:** `await` until the `Future` completes; avoid `addPostFrameCallback` in unit code under test when you can return a `Future` instead.

**File naming:** `something_test.dart` under `test/`.

**Run:** `flutter test test/path/to/something_test.dart`

---

## Widget tests

**Use for:** Buttons, forms, `ListTile` tap, dialog opens, `find.text` / `find.byKey` after `pump`, SnackBar after async.

**Entry:** `testWidgets('…', (tester) async { … })` from `package:flutter_test/flutter_test.dart`.

**Minimal harness:** Wrap the widget under test in whatever **ancestors** it needs:

- `MaterialApp` (or `MaterialApp.router` with the same `GoRouter` / `routerConfig` the screen expects).
- `Theme` / `MediaQuery` if the code reads `Theme.of` / `MediaQuery.of`.
- **Providers:** the same `ProviderScope` / `Provider` / `BlocProvider` tree the real app provides—**do not** “test the widget in isolation” if production code *requires* context that only exists with those ancestors.

**Pumping:**

- `await tester.pumpWidget(…);` for first frame.
- `await tester.pump();` for one frame after a tap/scroll.
- `await tester.pumpAndSettle();` when animations/implicit animations must finish; cap duration if a flow never settles (e.g. infinite `AnimationController`).

**Finders (prefer stable contracts):

- `Key` on the widget you care about (`ValueKey('submit')`) for lists and dynamic text.
- `find.text`, `find.byType`, `find.descendant`, `find.byWidgetPredicate` for behavior-focused assertions.
- `Semantics` / `tester.getSemantics` when accessibility is the contract.

**Gestures:** `tester.tap`, `enterText`, `drag`, `longPress`; for scrollables use `tester.scrollUntilVisible` or `tester.fling` as needed.

**Async + navigation:** If code does `async` then `Navigator.push`, use `pump`/`pumpAndSettle` after the `Future` the UI awaits; re-check invariants the same way production code would.

**Flaky widget tests** often come from: missing `pump` after state change, **real timers**, **layout-dependent** text (locale, `ScreenUtil`), or **infinite** animations—fix by controlling binding time, faking notifiers, or `skipOffstage: false` on finders when appropriate.

**Goldens (optional):** only if the repo already has `flutter_test` goldens; match existing `tags`, tolerance, and CI (often Linux vs macOS differences). New golden suites need explicit user/team agreement.

**Run:** `flutter test` or a single file path.

---

## Integration tests

**Use for:** end-to-end smoke: cold start, login, deep link, camera/location plugins, *real* platform behavior.

**Setup (standard Flutter `integration_test` package):**

1. Add to **app** `pubspec.yaml` under `dev_dependencies`:

   ```yaml
   integration_test:
     sdk: flutter
   ```

2. Create `integration_test/<name>_test.dart`.

3. In that file, use the integration binding and drive the app:

   ```dart
   import 'package:flutter_test/flutter_test.dart';
   import 'package:integration_test/integration_test.dart';
   // import 'package:your_app/main.dart' or a dedicated test entry;

   void main() {
     IntegrationTestWidgetsFlutterBinding.ensureInitialized();
     testWidgets('smoke', (tester) async {
       // pumpWidget with same bootstrap as a flavor entry if needed
     });
   }
   ```

4. **Entrypoint for flavors:** if the app uses `main_dev.dart` / flavors, the integration test may need to call the same `bootstrap` or `main()` used by that flavor, or a **test-only** `main` that sets env/flags. Mirror production wiring so the test exercises the right config.

5. **Run on device:**  
   `flutter test integration_test/your_test.dart`  
   or use `flutter drive` with the integration_test driver if the project/CI is set up that way. Prefer the approach already documented in the repo/CI.

**Differences from widget tests:** real engines, real plugins, slower, and **stricter** about async (network, permissions). Prefer **dedicated test backend** or **record/replay** if the user cannot hit production APIs from CI.

**Determinism:** use test accounts, idempotent data, and explicit waits (`pumpAndSettle` with care); avoid `sleep` in favor of `expect`+retry patterns or `pump` until a `Finder` matches.

**Env:** pass `--dart-define` consistently with the flavor under test; document the exact command the team should run (document in code comments or the PR, not a new doc file unless the user asked).

---

## Project alignment (sukmaapps / app_core)

- **State (Riverpod, etc.):** in widget/integration tests, **override** providers with fakes; read `.cursor/skills/riverpod-codegen` when codegen `Provider`s are in play.
- **DI (`get_it` / injectable):** register test doubles in `setUp` or a small `bootstrapTestDi()` that mirrors `app_core` registration; avoid registering production singletons that hit the network.
- **Routing (`go_router`):** supply the same `GoRouter` (or a minimal stub with the routes under test) inside `testWidgets` so `context.push` and deep links match reality.
- **Flavors / `.env`:** for integration, ensure assets like `.env` exist for the flavor, or use `dart-define` that your `main_*.dart` already reads; do not hardcode secrets in tests.

---

## Commands cheat sheet

- All tests in package: `flutter test`
- One file: `flutter test test/foo_test.dart`
- Coverage (when enabled): `flutter test --coverage`
- Update goldens (if used): `flutter test --update-goldens` (only with team agreement)

---

## What “good” looks like

- **Name** the behavior: `test('parses empty input as null', …)` not `test('works', …)`.
- **Arrange** minimal context; **act** one user or API step; **assert** one or two clear outcomes.
- **No** `print` in committed tests; use `throwsA`, `expectLater` for async errors.
- **Stability** over cleverness: a slightly longer test with explicit `Key`s beats a flake that passes 90% of the time.

When the user asks to “add tests” without specifying layer, start by **suggesting** unit for logic and widget for the screen; propose integration only for flows that depend on the real device or plugins.

---

## Test prompts (for skill evaluation, optional)

If the skill-creator eval loop is used, example prompts:

1. "Widget test for this login screen: tap email, type text, submit, expect error SnackBar" (widget).
2. "Unit tests for this date range validator function" (unit).
3. "Integration smoke: launch app, wait for home, scroll list once" (integration).

Save eval assets under the skill’s eval workspace per skill-creator, not in this folder, unless the team maintains `evals/evals.json` for this skill.
