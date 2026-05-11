---
name: feature-architecture
description: Design and implement feature-based app architecture with repository + datasource, domain param/entity, and clean-ish layering. Use this skill whenever the user asks about architecture, code organization, refactor structure, repository pattern, datasource/API boundaries, use case design, or data flow from UI to API—even if they only say "rapihin struktur", "benerin layering", or "alur data ini gimana".
---

# Feature Architecture (clean-ish)

Use this skill to keep architecture practical, scalable, and easy to reason about.
Target mindset: clear ownership per layer, stable domain contracts, and explicit data flow.

---

## Scope and intent

This skill helps you:

- organize code by **feature** (not by technical layer at app root),
- separate responsibilities across **UI/state/domain/data**,
- apply **repository + datasource** with explicit **data-boundary** conversion (DTO → entity),
- maintain a readable flow from **UI -> state -> use case/repository -> API**.

This is "clean-ish", not dogmatic clean architecture. Prefer consistency with the existing repo and avoid overengineering.

---

## Naming: singular feature folders

Use **singular** folder names under each feature (easier to scan, consistent imports):

- `entity/` not `entities/`, `param/` not `params/`, `repository/` not `repositories/`, `usecase/` not `usecases/`, `datasource/` not `datasources/`, `model/` not `models/`, `widget/` not `widgets/`, `screen/` not `pages/` unless the repo already standardized on another convention.

---

## Naming: file basenames (`topic_role.layer.dart`)

Avoid long all-snake names like `login_response_dto.dart`. Prefer a **short topic** + **layer role** separated by a **dot** before `.dart`:

- **Single-word topic:** `login.model.dart`, `login.param.dart`, `login.screen.dart`.
- **Multi-word topic:** join words with **`_`** (underscore), then **`.`** + role — e.g. `auth_local.datasource.dart`, `auth_remote.datasource.dart`, `auth_session.entity.dart`, `auth_repository.dart` (contract under `repository/`), **`auth_repository.impl.dart`** (implementation — use `.impl` not `_impl`).

The **extension remains `.dart`**. Dart analyzer, pub, Flutter, macOS, Linux, and Windows handle multiple dots in the basename normally. Avoid Windows reserved device names (`CON`, `PRN`, …) as basenames.

Barrel files such as `domain.dart`, `data.dart`, and `presentation.dart` may stay single-word.

---

## Trigger checklist

Read this skill fully when the user asks for:

- architecture setup or refactor,
- feature module/folder structure,
- repository pattern or datasource split,
- domain entity/param design,
- "how data moves" debugging between UI and backend.

If request is tiny (single-file quick fix), still apply the principles lightly without forcing a large rewrite.

---

## Default layering contract

Use this baseline unless project conventions require adjustments:

1. **Presentation**
   - **screen/** — route-level UI (Scaffold, one screen per primary flow).
   - **widget/** — reusable composition for this feature only.
   - **controller/** — orchestrates screen + domain (Notifier, Bloc, Cubit, ChangeNotifier, etc.).
   - **adapter/** — bridges to external/third-party UI or platform views when the rest of the feature stays clean.
   - **state/** — immutable view-state snapshots / sealed states when kept separate from the controller file.
   - No direct HTTP/API calls.
2. **Domain**
   - **entity/** — business-shaped objects (often called *domain models*).
   - **param/** — use case / repository call input.
   - **repository/** — contracts (abstract) for data orchestration.
   - **usecase/** — optional application operations composed over repositories.
3. **Data**
   - **repository/** — implementations of domain contracts.
   - **datasource/** — remote/local IO.
   - **model/** — DTOs (transport shape) and optional `toEntity()` / helpers on those types — conversion stays in this layer.
4. **Core/shared**
   - Common error/result wrappers, network client, utils.

Golden rule: dependencies point inward (presentation -> domain -> data abstractions), while implementations stay at the edges.

---

## Feature-based folder blueprint

Use one top-level folder per feature and keep related files close:

```text
lib/features/<feature_name>/
  presentation/
    screen/
    widget/
    controller/
    adapter/
    state/
  domain/
    entity/
    param/
    repository/
    usecase/
  data/
    datasource/
    model/
    repository/
```

Example filenames (illustrative):

- `domain/entity/auth_session.entity.dart`
- `domain/repository/auth_repository.dart`
- `domain/param/login.param.dart`
- `data/model/login.model.dart`
- `data/datasource/auth_local.datasource.dart`
- `data/datasource/auth_remote.datasource.dart`
- `data/repository/auth_repository.impl.dart`
- `presentation/screen/login.screen.dart`

**Contrast:** `domain/entity/` holds transport-agnostic business objects; `data/model/` holds API-shaped DTOs.

If an older path uses plural names (`entities/`, `models/`), migrating to singular is recommended when touching the feature; otherwise keep layer boundaries strict.

---

## Data flow model (must stay explicit)

For feature operations, keep this flow traceable:

1. UI event triggers state/action (often via **controller**).
2. Controller builds/validates **param**.
3. Controller calls use case or repository interface.
4. Repository impl chooses **datasource**(s).
5. Datasource returns **model** (DTO).
6. Repository impl (or DTO helper) converts DTO → **entity** (and optionally the reverse for writes).
7. Result bubbles back to controller/state.
8. **screen** / **widget** render UI-friendly state (loading, data, error).

When debugging, identify exactly which hop fails instead of guessing across layers.

---

## Repository + datasource rules

- Repository is the orchestration boundary, not a thin HTTP proxy.
- Datasource is IO-focused (API endpoint calls, caching adapters, persistence).
- Keep API contracts (DTO fields, raw response shape) out of presentation and domain.
- Domain should consume stable entity/param types, not transport-specific structures.
- Keep DTO→entity conversion in the **data layer** (repository impl or small methods on DTOs); extract a private helper only if one method grows unwieldy — avoid a mandatory `mapper/` folder.

Use repository interfaces in domain when testability and decoupling are needed; avoid adding abstractions that do not reduce coupling.

---

## Domain param and entity

Here **domain model** means the same as **entity** (business-shaped data, not API-shaped).

Design domain input/output with intent:

- **Param** describes use case or repository input (validated, minimal, explicit).
- **Entity** carries business meaning, not backend naming quirks.
- Nullable fields must communicate meaning (`unknown` vs `optional` vs `not provided`).
- Convert API oddities in the **data layer**, not in UI/state.

Prefer small, composable types over giant "everything bagel" objects.

---

## State layer responsibilities

State should:

- manage loading/success/error lifecycle,
- call domain entry points (use case/repository interface),
- keep UI state derivation local (filter, sorting, selected tab),
- expose immutable/readable state for UI rendering.

State should not:

- parse raw HTTP payload,
- know endpoint paths,
- implement business orchestration that belongs in domain/repository.

---

## Refactor playbook (safe, incremental)

When moving a messy module to this architecture:

1. Map current flow from UI to API as-is.
2. Introduce domain entity/param first.
3. Extract datasource from direct API calls.
4. Add repository implementation as integration boundary.
5. Move controller/state to call repository/use case only.
6. Keep behavior stable; refactor in small slices.
7. Add/update tests around core flow.

Avoid big-bang rewrites unless user explicitly asks for it.

---

## Output format for architecture requests

When user asks for architecture design/review, use this structure:

## 1) Proposed structure
- feature folders and key files

## 2) Layer responsibilities
- what each layer owns and forbids

## 3) Data flow
- UI -> controller/state -> use case/repo -> datasource/API -> DTO→entity (data layer) -> screen/widget

## 4) Migration steps
- incremental steps with lowest-risk order

## 5) Risks and trade-offs
- complexity, testability, team familiarity, and rollout impact

Keep it concise and actionable; tie recommendations to existing code style.

---

## Anti-patterns to avoid

- Shared "god repository" used by unrelated features.
- UI calling API clients directly.
- Domain importing API DTO classes.
- DTO parsing or DTO→entity conversion duplicated or scattered across UI/state/controller files.
- Generic abstractions added before a real duplication/pain point exists.

---

## Quick delivery checklist

- [ ] Feature boundary is clear and isolated.
- [ ] Data flow can be traced hop-by-hop.
- [ ] Repository/datasource split is explicit.
- [ ] Domain entity/param are transport-agnostic.
- [ ] Changes are incremental and aligned with existing conventions.
