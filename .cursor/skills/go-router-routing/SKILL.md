---
name: go-router-routing
description: Build and refactor Flutter app routing with go_router using declarative route trees, typed/structured navigation inputs, and clear guard/redirect flow. Use this skill whenever the user mentions routing, navigation, route guards, nested routes, shell routes, URL paths, query params, or deep links—even if they only ask "pindah halaman", "rapihin navigator", or "link langsung ke screen ini".
---

# Go Router Routing (declarative)

Use this skill to keep navigation predictable and maintainable with `go_router`.
Default approach: declarative route config, explicit path/query handling, and guarded transitions.

---

## Scope

This skill helps you:

- define route trees declaratively,
- structure navigation API usage from UI/state,
- apply redirects/guards without scattering logic,
- prepare deep link support when product needs it.

Prefer minimal, incremental changes that match existing project style.

---

## When to apply

Read this skill fully when user asks about:

- `go_router` setup or migration,
- route cleanup/refactor,
- nested route or tab shell navigation,
- auth/onboarding guards and redirects,
- URL path/query parameter handling,
- deep link behavior.

For tiny fixes, apply only relevant parts without over-architecting.

---

## Core principles

1. Keep routing declarative in one cohesive config area.
2. Use stable route names/paths; avoid ad-hoc string literals in UI.
3. Parse and validate incoming params at route boundary.
4. Keep business logic out of route builder; route layer decides navigation only.
5. Put auth/access checks in redirect/guard flow, not inside random widgets.

---

## Route structure blueprint

Typical structure (adapt naming to repo):

```text
lib/app/routing/
  app_router.dart          # GoRouter instance + redirect
  route_names.dart         # route name/path constants
  route_builders.dart      # page builders if needed
  route_guards.dart        # auth/role checks (optional)
```

Feature modules can expose route entries, but final composition should stay centralized so the tree remains discoverable.

---

## Declarative go_router guidance

- Define routes with clear parent-child hierarchy.
- Use `ShellRoute`/stateful shell patterns for tab-based layouts when needed.
- Prefer named routes for app-internal navigation readability.
- Use path params for identity (`/users/:id`) and query params for optional filters (`?tab=activity`).
- Keep page construction simple; map route state to screen input in one place.

When adding new routes, update constants and route table together.

---

## Navigation usage from UI/state

Use simple rules:

- UI event triggers navigation intent.
- UI/state calls `context.go`, `context.push`, `context.replace` intentionally:
  - `go`: replace stack to a location,
  - `push`: stack forward for drill-down,
  - `replace`: swap current page when back behavior should not return.
- Avoid mixing old `Navigator` APIs unless project still has hybrid migration in progress.

Do not hide navigation inside deep infrastructure layers; keep it near presentation flow.

---

## Redirect and guard flow

Guard logic should be deterministic and side-effect-light:

1. Read current auth/session/access state.
2. Decide allowed vs blocked destination.
3. Return target redirect path or null.

Keep guard rules centralized and testable. Prevent redirect loops by explicitly handling already-allowed destinations.

---

## Deep link readiness (enable when needed)

Default: keep route definitions and param parsing deep-link friendly even if not yet activated.

When deep link becomes required:

- ensure each public destination has stable path schema,
- decode and validate path/query payload safely,
- support app cold start + resumed state behavior,
- handle unknown/expired links with fallback screen.

Do not build full deep link infra early unless product asks for it.

---

## Suggested output format for routing tasks

## 1) Route map
- route tree (parent/child, shell if any)

## 2) Navigation contracts
- route names, path params, query params

## 3) Guard/redirect rules
- auth/access/onboarding decisions and loop prevention

## 4) Deep link plan
- what is ready now vs what is deferred

## 5) Migration steps
- smallest safe sequence to ship

Keep recommendations concrete and aligned with existing code.

---

## Anti-patterns to avoid

- Route strings hardcoded across many widgets.
- Guard logic duplicated inside page widgets.
- Parsing route params directly in UI multiple times.
- Redirect logic with hidden side effects (network calls, mutable global writes).
- Introducing deep link complexity before there is product demand.

---

## Quick checklist

- [ ] Route config is declarative and discoverable.
- [ ] Path/query params are parsed and validated at boundary.
- [ ] `go` vs `push` semantics are intentional.
- [ ] Redirect rules are centralized and loop-safe.
- [ ] Deep link support is ready-by-design, implemented only as needed.
