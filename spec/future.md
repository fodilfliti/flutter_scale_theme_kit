# Future look-kit work

Advice for agents and humans. **Do not implement this file as one dump.** Pick **one** item from [tasks/T15-pick.md](tasks/T15-pick.md), then only that task.

Look (`STTheme`, `context.st`, `ThemeData`) stays here. Size stays in `flutter_scale_kit`.

Industry shape (keep): **tokens → ThemeData + ThemeExtension → no hardcoded colors in screens.** v1 already follows that. Remaining work is gaps apps hit after v1.

## Already done (do not redo)

- Semantic colors + authored light/dark (no `fromSeed` default)
- `ThemeExtension` + `context.st`
- Most Material component themes — [material-map.md](material-map.md)
- Extras + generate (`Color` / `ButtonStyle` / `BoxDecoration` / `TextStyle`) — [generate.md](generate.md)
- No `STCard` / `STButton`

## Ranked later (real app pain)

| Order | Item | Task |
| --- | --- | --- |
| 1 | Widget states (hover / press / focus / disabled / selected) on extras → `WidgetStateProperty` in `ButtonStyle` / input | [T16](tasks/T16-widget-states.md) **done** |
| 2 | Unscaled `TextTheme` size tokens (`display` / `title` / `body`) — no `.sp` here | [T17](tasks/T17-type-scale.md) |
| 3 | Motion tokens (`context.st.motion.fast`) — duration + curve | [T18](tasks/T18-motion.md) |
| 4 | Debug contrast asserts + gallery states (disabled, dark, text scale) | [T19](tasks/T19-contrast-a11y.md) |
| 5 | Remaining `ThemeData` slots as needed (`menu`, `carousel`, `dataTable`, …) | [T20](tasks/T20-themedata-slots.md) |
| 6 | Extra kinds (`icon`, `input`) + optional high-contrast / dynamic-color **adapter** | [T21](tasks/T21-extra-kinds.md) |

Generate later kinds (same product, still no `build_runner`): **icon** → `IconThemeData`; **input** extra → `InputDecoration`; chip / listTile / overlay; state on generated `ButtonStyle`. CLI stays `generate [watch] [file]`.

## Keep out unless the split changes

| Tempting add | Why not here |
| --- | --- |
| Spacing / padding scale | `flutter_scale_kit` |
| Font scaling / language fonts | `FontConfig` + `createResponsiveTextTheme` |
| `STButton` / `STCard` | Fights SK* and stock widgets |
| `ColorScheme.fromSeed` as default | Invents dark palette |
| Figma / Tokens Studio | Tooling, not runtime |
| Cupertino | Separate theme family |
| Dynamic Color as default | Optional adapter only, brand fallback required |

Richer `surfaceContainer*` steps: only if the user **authors** extra surface tokens. Do not invent them.
