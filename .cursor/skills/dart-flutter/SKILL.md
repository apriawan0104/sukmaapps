---
name: dart-flutter
description: Build and review Dart and Flutter code using current SDK practices—widgets, composition, and Material/Cupertino patterns; async/await, Futures, Streams, and error handling; null safety and sound types; and basic tests with flutter_test and widget tests. Use this skill whenever the user works on Flutter apps, Dart packages, mobile or desktop Flutter, Riverpod/Provider/Bloc, hot reload, pubspec, lints, or asks about Dart 3 features, const constructors, BuildContext, or test/widget_test—even if they only say "my Flutter screen" or "fix this Dart function."
---

# Dart & Flutter (modern core)

This skill steers you toward **current Dart/Flutter conventions**: predictable widget trees, safe async, explicit nullability, and tests that are easy to maintain. Prefer the **stable channel** and **language version** from `pubspec.yaml` as the source of truth for which features are available.

---

## When to read this fully

- New screens, widgets, or state wiring.
- Refactors touching `async`, `Stream`, or nullable APIs.
- Adding or fixing `test/` / `widget_test/`.
- Reviewing code for lints, performance (rebuilds), or API safety.

---

## SDK & project shape

- **Versions**: Check `environment.sdk` in `pubspec.yaml` and `analysis_options.yaml` for lints. Dart 3 implies **patterns**, **records**, and **class modifiers** when the project already opts in—match existing project style, do not mix eras arbitrarily.
- **Entry**: `lib/main.dart` for apps; packages expose a clear public API from `lib/<package_name>.dart`.
- **Futures vs sync**: I/O, platform channels, and http are async—do not block the UI isolate with heavy sync work; use `compute` or isolates for large CPU work when the team already does so.

---

## Widgets: composition over inheritance

- Prefer **small widgets** and **const** where possible so the element tree stays cheap to rebuild. Const constructors and immutable fields reduce avoidable work.
- **StatelessWidget** for pure UI from inputs; **StatefulWidget** when local ephemeral UI state (controllers, animation tickers) truly belongs in the widget. For app-wide or cross-screen state, use whatever the project already uses (Provider, Riverpod, Bloc, etc.)—**do not introduce a new state library** without a strong reason and user approval.
- **BuildContext** is valid only for the current build phase; do not store it past async gaps without ensuring the widget is still mounted (`mounted` in `State`, or `context.mounted` in async callbacks after the gap).
- **Keys**: Use `ValueKey` / `ObjectKey` when the framework must distinguish list items or preserve state; avoid random keys that defeat reconciliation.

---

## Async: clear boundaries

- **async/await**: Keep async functions `Future<void>`-shaped for event handlers; propagate errors to the user or loggers instead of silent failures.
- **After `await`**: Re-check **mounted** (or `context.mounted`) before `setState` or navigation.
- **Streams**: Prefer explicit subscription lifecycle (`StreamSubscription` cancel in `dispose`) or the project's stream helpers. Avoid leaking subscriptions.
- **UI feedback**: For long work, the project may use `FutureBuilder`/`StreamBuilder` or loading notifiers—follow existing patterns for spinners, disabled buttons, and error SnackBars.

---

## Null safety (sound null safety)

- **Never** use `!` to silence analysis without a local invariant or early return. Prefer:
  - **Guards** (`if (x == null) return;` then use `x`).
  - **Late** only when assignment happens before first read in a controlled lifecycle (e.g. `initState`).
  - **Required named parameters** and **assertions** in debug for impossible states.
- Distinguish **empty** (e.g. empty list) from **absent** (`null`) when the API meaning differs.

---

## Testing (dasar / fundamental)

- **Unit tests** (`test/…_test.dart`): `package:test` / `flutter_test`—test **pure functions** and small notifiers; mock I/O with fakes the project already uses.
- **Widget tests**: `testWidgets` + `WidgetTester`; `await tester.pumpWidget(…)` and `pumpAndSettle` when animations or async complete. **Always** add something meaningful: finders (`find.text`, `find.byType`), a key interaction, and an `expect`.
- **Golden tests**: Only if the repo already has them; follow existing tolerance and CI setup.

Keep tests **deterministic**: fake clocks and stable screen sizes if the test depends on time or layout.

---

## Style that matches most codebases

- Run **dart format**; respect **very_good_analysis** or **lints** if present.
- **Imports**: `dart:` first, then `package:`, then relative; avoid unused imports.
- **Public API**: Document with `///` for packages; for app code, follow repo density (often brief or none for private helpers).

---

## Anti-patterns to avoid

- Huge `build` methods with deep nesting—extract widgets.
- Unbounded `ListView` children when lazy loading exists—use list builders as the project does.
- Ignoring `mounted` after async in `StatefulWidget`—causes setState on defunct elements.
- Disabling lints or using `// ignore` broadly instead of fixing the root issue.

---

## If information is missing

- Inspect **pubspec.yaml**, **analysis_options.yaml**, and one existing feature file to mirror **patterns, imports, and state management**.
- Do not assume **null-unsafe** legacy unless the file clearly uses it.

---

## Quick checklist before finishing a change

- [ ] Null-safe paths; no unnecessary `!`.
- [ ] Async gaps followed by `mounted` / `context.mounted` checks where UI updates occur.
- [ ] Const widgets where it helps; keys for dynamic lists if needed.
- [ ] If tests were touched or behavior changed: a test or update to an existing one when the project tests similar code.

When in doubt, **match the surrounding codebase** and keep the diff **minimal** to the user’s request.
