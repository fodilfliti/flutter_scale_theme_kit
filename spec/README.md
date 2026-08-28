# Agent memory map

This folder is the **durable brain** for AI agents working on Flutter Scale Theme Kit.
It is not user documentation. Do not copy `README.md` here.

| File | Read when |
| --- | --- |
| [package.md](package.md) | Starting a task: what the package is, layers, public surface |
| [invariants.md](invariants.md) | Changing tokens, ThemeData factory, context API, or dependencies |
| [decisions.md](decisions.md) | Changing architecture or public names |
| [tokens.md](tokens.md) | Adding or renaming token fields |
| [material-map.md](material-map.md) | Mapping tokens to `ThemeData` / `ColorScheme` / widgets |
| [companion.md](companion.md) | Dual-package use with `flutter_scale_kit` |
| [generate.md](generate.md) | JSON / Dart extras generator |
| [future.md](future.md) | Ranked later look-kit work; pick one before coding |
| [tasks/README.md](tasks/README.md) | Picking an implementation task |

Consumer apps (other IDEs): `skills/flutter-scale-theme-kit/` (`npx skills add fodilfliti/flutter_scale_theme_kit`). If you change a public API, update that skill in the same change.

## Truth order

1. **Code** in `lib/` — implementation truth.
2. **This folder** — product intent, invariants, and why.
3. **`CHANGELOG.md`** — what changed recently.
4. **`README.md`** — user-facing docs and recipes only. Do not load it as session memory.
5. **`example/`** — demo only, not the public API contract.

When code and spec disagree, **fix the spec** after confirming the code is intentional.

## Companion package

`flutter_scale_kit` lives in a sibling repo. Its spec is **not** this package’s spec. Do not modify scale_kit unless the user asks. Do not import it from `lib/`.
