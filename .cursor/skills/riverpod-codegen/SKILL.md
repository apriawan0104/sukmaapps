---
name: riverpod-codegen
description: Build and refactor Flutter state management with Riverpod and riverpod_generator, including @riverpod code generation, AsyncValue handling, provider families, and testable notifier patterns. Use this skill whenever the user mentions Riverpod, riverpod_generator, provider codegen, AsyncNotifier/Notifier, ref.watch/ref.read/ref.listen, state architecture, or asks to migrate from setState/Provider/Bloc to Riverpod.
---

# Riverpod + riverpod_generator

Use this skill to produce consistent, modern Flutter state management with Riverpod code generation.

---

## Scope

- Create new state modules with `riverpod_annotation` + generated providers.
- Refactor existing state logic into `Notifier`/`AsyncNotifier` patterns.
- Standardize loading, error, and retry flows with `AsyncValue`.
- Keep state code testable and side effects isolated.

---

## First checks

Before changing code:

- Confirm project already uses Riverpod, or user explicitly asks to introduce it.
- Check `pubspec.yaml` for:
  - `flutter_riverpod`
  - `riverpod_annotation`
  - `riverpod_generator` (dev dependency)
  - `build_runner` (dev dependency)
- Match the existing naming and folder convention in the repo.

If dependencies are missing and user wants Riverpod setup, add them first with the package manager and then generate code.

---

## Default architecture

Prefer this shape unless repo conventions differ:

1. **Data layer**: repository/service abstractions (API, local storage).
2. **State layer**: Riverpod providers (`@riverpod` functions/classes).
3. **UI layer**: widgets consume providers via `ref.watch`.

Rules:

- Keep network/storage calls in repositories, not widgets.
- Keep UI-specific ephemeral state local unless shared across screens.
- Use `family` providers for parameterized state.
- Avoid passing `BuildContext` into providers.

---

## Provider patterns

### 1) Read-only synchronous state

Use function provider:

```dart
@riverpod
int counter(CounterRef ref) => 0;
```

### 2) Mutable synchronous state

Use `Notifier` class provider:

```dart
@riverpod
class CartCount extends _$CartCount {
  @override
  int build() => 0;

  void increment() => state++;
}
```

### 3) Async state (API, DB, file)

Use `AsyncNotifier` class provider and return real data from `build()`:

```dart
@riverpod
class UserProfile extends _$UserProfile {
  @override
  Future<User> build(String userId) async {
    final repo = ref.watch(userRepositoryProvider);
    return repo.getUser(userId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(userRepositoryProvider);
      return repo.getUser(this.arg);
    });
  }
}
```

---

## AsyncValue conventions

- Use `AsyncValue.guard` for async mutations that can fail.
- In UI, handle `loading`, `error`, and `data` explicitly.
- Avoid swallowing errors; surface actionable messages.
- Prefer retry actions that call notifier methods (`refresh`, `retry`, etc.).

Minimal UI pattern:

```dart
final profile = ref.watch(userProfileProvider(userId));
return profile.when(
  loading: () => const CircularProgressIndicator(),
  error: (e, st) => ErrorView(onRetry: () => ref.read(userProfileProvider(userId).notifier).refresh()),
  data: (user) => ProfileView(user: user),
);
```

---

## ref.watch vs ref.read vs ref.listen

- `ref.watch`: reactive read in `build`/provider; rebuilds on change.
- `ref.read`: one-time access for commands (button tap, notifier methods).
- `ref.listen`: side effects (snackbar, navigation, logging), not UI data rendering.

Do not replace all reads with `watch`; choose based on reactivity needs.

---

## Code generation workflow

After editing providers:

1. Ensure each provider file includes:
   - `part '<file_name>.g.dart';`
2. Run codegen:
   - `dart run build_runner build --delete-conflicting-outputs`
3. For active development, watch mode is acceptable:
   - `dart run build_runner watch --delete-conflicting-outputs`

Never hand-edit generated `.g.dart` files.

---

## Migration guidance (common requests)

When migrating from `setState` / classic `Provider` / `Bloc`:

- Move business logic to repository + notifier.
- Keep widget responsibilities to rendering + user interactions.
- Convert imperative loading flags into `AsyncValue`.
- Keep old behavior parity first; optimize after parity.
- Migrate feature-by-feature, not whole app in one risky step.

---

## Testing expectations

For state changes, prefer adding tests when repo already has test patterns:

- Unit test notifier methods (success + failure paths).
- Verify state transitions (`loading -> data` or `loading -> error`).
- Override dependencies using provider overrides in tests.

Keep tests deterministic with fake repositories.

---

## Anti-patterns

- Business logic in widgets.
- Global mutable singletons outside providers.
- Triggering network calls repeatedly in widget build without caching strategy.
- Ignoring `.when` error branch in UI.
- Mixing multiple state libraries in one feature without explicit reason.

---

## Delivery checklist

- [ ] Provider type chosen correctly (`Provider`, `Notifier`, `AsyncNotifier`).
- [ ] Side effects stay in notifier/repository, not scattered in UI.
- [ ] UI handles loading/error/data explicitly.
- [ ] Codegen re-run and generated files updated.
- [ ] Naming and structure follow existing project conventions.
