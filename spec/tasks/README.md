# Implementation tasks

Pick **one** `Txx-*.md` file. Do not skip **Read first**. Do not start a later task before its blockers are done.

Done = tests pass, `dart analyze` is clean on `lib/` and `test/`, and you did not violate [invariants.md](../invariants.md).

| Task | Blocked by | Summary |
| --- | --- | --- |
| [T00](T00-brain-lock.md) | — | Spec/AGENTS already the source of truth; do not rewrite unless asked |
| [T01](T01-bootstrap.md) | T00 | Strip old lib, SDK, empty barrel |
| [T02](T02-st-color.md) | T01 | `STColor` |
| [T03](T03-st-colors.md) | T02 | `STColors` + extra |
| [T04](T04-tokens.md) | T03 | Radius, shadows, type, components |
| [T05](T05-color-scheme.md) | T04 | ColorScheme fill table |
| [T06](T06-theme-data.md) | T05 | `STTheme` ThemeData factory + extension |
| [T07](T07-context-st.md) | T06 | `context.st` |
| [T08](T08-extras.md) | T07 | `container('highlighted')` |
| [T09](T09-independence.md) | T01 | Prove no scale_kit in lib |
| [T10](T10-companion-example.md) | T07 | Example + scale_kit recipe |
| [T11](T11-gallery.md) | T07 | Widget gallery, light/dark |
| [T12](T12-readme.md) | T07 | README + CHANGELOG |
| [T13](T13-generate.md) | T08 | Typed extras (`STKind`) + JSON → Dart generator |
| [T14](T14-generate-from-dart.md) | T13 | Generate `ghostButton` getters from Dart `STExtra.*` (no JSON) |
| [T15](T15-pick.md) | T14 | User picks **one** later look item; no code |
| [T16](T16-widget-states.md) | T15 | Widget states → `WidgetStateProperty` |
| [T17](T17-type-scale.md) | T15 | Unscaled `TextTheme` size tokens |
| [T18](T18-motion.md) | T15 | Motion tokens on `context.st` |
| [T19](T19-contrast-a11y.md) | T15 | Debug contrast + gallery states |
| [T20](T20-themedata-slots.md) | T15 | Remaining `ThemeData` look slots |
| [T21](T21-extra-kinds.md) | T15 | Extra kinds (`icon`, `input`) + optional adapters |

T09 can run after T01 in parallel with T02–T08. T10–T12 after T07. T13 after T08. T14 after T13. T16–T21: **only the one T15 names** — see [future.md](../future.md).
