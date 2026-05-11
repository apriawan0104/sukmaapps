---
name: dio-http
description: Build and refactor HTTP networking in Flutter using Dio with a clean client setup, base URL management, interceptors, auth header injection, and consistent error handling. Use this skill whenever the user mentions API calls, HTTP client setup, token/auth header, request/response interceptors, retries, timeout, or networking bugs—even if they only say "API error", "rapihin dio", or "request ini gagal terus".
---

# Dio HTTP (production-ready basics)

Use this skill to keep networking predictable, testable, and easy to debug.
Focus on one consistent pipeline: request config -> interceptor chain -> response mapping -> domain-safe errors.

---

## Scope

This skill helps you:

- set up a reusable Dio client,
- manage `baseUrl` and environment-specific config,
- inject auth headers safely,
- standardize HTTP error handling and propagation.

Prefer small, safe changes aligned with existing code style.

---

## When to apply

Use this skill for:

- new API client setup,
- refactor from scattered `Dio()` usage,
- token header and refresh flow cleanup,
- inconsistent error mapping,
- interceptor logging/diagnostics.

For one-off endpoint fixes, still apply consistent patterns without broad rewrites.

---

## Core networking contract

1. **Single client source**: create/configure Dio in one place.
2. **Config first**: base URL, timeout, default headers, content type.
3. **Interceptors own cross-cutting behavior**: logging, auth header, retry/refresh hooks.
4. **Datasource handles transport**: request/response DTO.
5. **Repository/domain receives normalized result or mapped error**.

Avoid leaking raw transport concerns into UI/state layers.

---

## Base URL and environment setup

- Define base URL from environment/config layer (dev/staging/prod).
- Do not hardcode full URL strings across datasources.
- Keep endpoint path composition explicit (`/users`, `/orders/:id` style).
- Set conservative default timeouts and override only when justified.

If the app supports multiple backends, expose distinct configured clients or a typed endpoint config, not ad-hoc runtime string concatenation.

---

## Interceptor design

Recommended interceptor responsibilities:

- **Request interceptor**:
  - attach auth header/token,
  - attach correlation/request id if used,
  - lightweight request logging in debug mode.
- **Response interceptor**:
  - central logging/metrics hooks,
  - pass through successful payloads.
- **Error interceptor**:
  - normalize DioException into app-level failure shape,
  - handle unauthorized flow hooks (refresh/sign-out trigger),
  - preserve useful diagnostics for debugging.

Keep interceptors deterministic; avoid heavy side effects and business branching there.

---

## Auth header strategy

Use an explicit token provider boundary:

1. Read latest token from secure/auth state provider.
2. Inject `Authorization: Bearer <token>` when endpoint needs auth.
3. Skip header for public endpoints via clear rule/flag.

If token refresh exists:

- prevent concurrent refresh storms,
- retry original request only when refresh succeeds,
- fail fast and propagate logout/session-expired action when refresh fails.

Do not duplicate token injection logic across each API method.

---

## Error handling standard

Normalize Dio errors into app-friendly categories, e.g.:

- timeout,
- network/unreachable,
- unauthorized/forbidden,
- validation/business error,
- server error,
- unknown error.

Rules:

- keep raw status/data for diagnostics,
- map to user-safe message at boundary,
- return consistent failure type from datasource/repository.

UI should consume stable failure contracts, not raw `DioException`.

---

## Suggested file organization

```text
lib/core/network/
  dio_client.dart
  dio_options.dart
  interceptors/
    auth_interceptor.dart
    logging_interceptor.dart
    error_interceptor.dart
  failures/
    network_failure.dart
    failure_mapper.dart
```

Feature datasources consume this client, not instantiate new Dio objects.

---

## Debugging flow for HTTP issues

When API fails, trace in this order:

1. Final request URL and method.
2. Required headers (especially auth).
3. Request body/query serialization.
4. Response status and payload.
5. Error mapping path to app-level failure.

Pinpoint the failing layer before changing code broadly.

---

## Output format for HTTP architecture tasks

## 1) Client setup
- where Dio is configured (baseUrl, timeout, defaults)

## 2) Interceptor chain
- request/response/error responsibilities

## 3) Auth header flow
- token source, injection rules, refresh behavior

## 4) Error model
- transport error -> normalized app failure mapping

## 5) Migration plan
- incremental steps with minimal risk

Keep it concrete and tied to current codebase conventions.

---

## Anti-patterns to avoid

- Creating new `Dio()` instances per request/file.
- Hardcoded base URL in many datasources.
- Catching and swallowing errors without failure mapping.
- Returning raw `DioException` directly to UI.
- Mixing auth refresh logic into unrelated feature code.

---

## Quick checklist

- [ ] Single reusable Dio client exists.
- [ ] baseUrl and timeout come from config/environment.
- [ ] Auth header injection is centralized.
- [ ] Error handling returns normalized failure types.
- [ ] Interceptor logic is clear, minimal, and testable.
