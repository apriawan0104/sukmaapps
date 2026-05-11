---
name: mobile-ux
description: Build and refine Flutter mobile UX with responsive layout using flutter_screenutil, localization with intl, and consistent screen patterns for loading/error/empty/content states. Use this skill whenever the user asks about UI polish, responsive behavior, localization/i18n, text formatting by locale, or loading/error UX—even if they only say "UI pecah", "bikin lebih rapi di HP", or "translate halaman ini".
---

# Mobile UX (responsive + i18n + state patterns)

Use this skill to make mobile experience feel stable and intentional across devices and languages.
Prioritize clarity, consistent state handling, and predictable layout scaling.

---

## Scope

This skill helps you:

- apply responsive sizing with `flutter_screenutil`,
- implement or refine localization via `intl`,
- enforce a reusable screen pattern for loading/error/empty/content.

Prefer incremental improvements over large visual rewrites.

---

## When to apply

Read this fully when user asks about:

- broken layout on smaller/larger phones,
- inconsistent spacing/typography across devices,
- localization/translation and locale formatting,
- poor loading or error screen experience.

For quick fixes, still keep the same UX contract and avoid one-off hacks.

---

## UX baseline principles

1. UI must be readable on common phone sizes without clipping/overlap.
2. Spacing and typography scale consistently, not randomly.
3. Text must be localizable (no hardcoded user-facing strings).
4. Every data-driven screen handles all states explicitly:
   - loading,
   - success/content,
   - empty,
   - error.
5. Feedback and recovery actions must be clear (retry, back, refresh).

---

## Responsive with flutter_screenutil

Apply `flutter_screenutil` intentionally:

- Initialize once at app root (`ScreenUtilInit`) with design size that matches design source.
- Use `.w`, `.h`, `.r`, `.sp` for dimensions/font where scaling is expected.
- Keep semantic constraints first (`Expanded`, `Flexible`, `LayoutBuilder`) before forcing sizes.
- Avoid over-scaling tiny spacing/font to the point of visual noise.
- Respect safe areas, keyboard insets, and scrolling on smaller heights.

Use fixed values only when truly static by design.

---

## i18n with intl

Localization rules:

- Keep all user-facing strings in localization resources, not inline literals.
- Use generated localization access (`S.of(context)` or project equivalent).
- Format date/number/currency with locale-aware `intl` utilities.
- Support interpolation/plurals in translation keys, not manual string concatenation.
- Provide fallback behavior for missing translations.

Do not mix translated and hardcoded text in the same UI flow.

---

## Screen state pattern (loading/error/empty/content)

Use a predictable rendering contract:

1. **Loading**: skeleton/progress that preserves expected layout footprint.
2. **Error**: concise message + clear retry action.
3. **Empty**: informative empty-state copy + next best action.
4. **Content**: primary data with progressive enhancements.

Keep this pattern reusable via shared widgets/builders when repeated.

---

## Suggested structure for reusable UX primitives

```text
lib/presentation/shared/
  widgets/
    app_loading_view.dart
    app_error_view.dart
    app_empty_view.dart
    app_state_container.dart   # switch loading/error/empty/content
  theme/
    app_spacing.dart
    app_typography.dart
```

Feature screens should compose these primitives, not reinvent each state UI.

---

## Practical design rules

- Keep touch targets reasonably large and accessible.
- Avoid long unbroken text blocks; allow wrapping/truncation with intent.
- Use consistent spacing scale across screens.
- Keep primary CTA visible and meaningful in both success and empty/error cases.
- Ensure pull-to-refresh/loading indicators do not conflict with empty/error layout.

---

## Output format for UX requests

## 1) Responsive plan
- what scales with ScreenUtil and what stays fixed

## 2) i18n plan
- key extraction, locale formatting, and fallback strategy

## 3) Screen state contract
- loading/error/empty/content rendering and actions

## 4) Reusable components
- shared widgets/utilities to avoid duplication

## 5) Rollout steps
- smallest safe sequence to implement

Keep outputs actionable and tied to current project conventions.

---

## Anti-patterns to avoid

- Hardcoded sizes everywhere without responsive rationale.
- Hardcoded user-facing strings inside widgets.
- Loading spinner only, with no empty/error differentiation.
- Different retry/error UX style on every screen.
- Forcing exact pixel-perfect behavior that breaks on device diversity.

---

## Quick checklist

- [ ] Screen remains readable across representative phone sizes.
- [ ] Spacing/font scaling uses ScreenUtil consistently.
- [ ] User-facing text is localizable and locale-formatted where needed.
- [ ] loading/error/empty/content states are explicit and reusable.
- [ ] Retry/recovery actions are clear for failure scenarios.
