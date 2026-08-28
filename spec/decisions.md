# Decisions

Record *why*. Update this file when you change the trade-off.

## D1 — Companion, not a fork of scale_kit

**Choice:** Separate package, no dependency on `flutter_scale_kit`.

**Why:** Users must install size and look independently. A path/pub dependency would force scale_kit onto look-only apps and risk a cycle later.

**Do not:** Import scale_kit from `lib/`, wrap `ScaleKitBuilder` inside this package, or duplicate `.w` / `SKSize`.

## D2 — ThemeExtension, not Provider

**Choice:** Put resolved tokens on `ThemeData.extensions`. `context.st` reads that. Optional `STScope` InheritedWidget for overrides.

**Why:** `MaterialApp(theme: st.light)` is enough. Provider is an extra dependency and a second source of truth.

**Do not:** Add `provider`. Look tokens stay on `ThemeExtension`. Optional [STThemeModeController] / [STThemeModeScope] is only for `MaterialApp.themeMode` (light/dark/system), not a second token store.

## D3 — No ST\* widgets in v1

**Choice:** Do not ship `STCard` / `STButton`.

**Why:** Scale Kit’s recommended style is tokens + `SK*` + `SKit.*Size`. A second widget family fights that. Stock Flutter widgets already inherit `ThemeData`. Containers that are not Material take `color: context.st.surface`.

**Do not:** Add `STCard` / `STButton` / `STInput`. `STThemeModeSwitch` is a stock `Switch` wired to [STThemeModeScope], not a look widget.

## D4 — Prefix `ST` / `context.st`

**Choice:** `STTheme`, `STColor`, `context.st`.

**Why:** Pairs with `SK` / `SKit` / `.w`. Avoid `Design*` (generic) and `ScaleThemeData` (name collision with scale_kit’s `ScaleThemeDataExtension`).

## D5 — Explicit colors, not seed-first

**Choice:** Users pass `STColor(light:, dark:)`. ColorScheme slots are filled from those tokens. No default `fromSeed`.

**Why:** Designers own light and dark. Seed invents a palette and a dark scheme they did not author.

**Do not:** Make `seedColor` the primary constructor.

## D6 — Radius lives in two places by design

**Choice:** This package stores **unscaled** radius for `ThemeData` (raw `Card` / `ElevatedButton`). Scale_kit stores **scaled** radius via `SKSize` / `SK*` when both packages are used.

**Why:** This package cannot call `.rSafe` without depending on scale_kit. Align numbers in the **app** (`setRadiusSizes(md: 12)` and `STRadius(md: 12)`).

## D7 — FontConfig stays in scale_kit

**Choice:** Typography here is color, weight, letter-spacing, optional family. Language fonts stay `FontConfig` in scale_kit.

**Why:** Dual-package apps compose: `st.light.copyWith(textTheme: st.light.createResponsiveTextTheme(st.light.textTheme))`. Do not reimplement FontConfig.

## D9 — Named STComponents for production Material widgets

**Choice:** Optional slots for every widget whose **shape/elevation** apps override (FAB, chip, nav, dialog, search, slider, pickers, …). Color-only look still comes from `STColors`. Shared `button` merges into specific button types.

**Why:** Production apps need typed overrides without `extra['fab']`. Mapping every Flutter class as required would bloat the constructor; all slots stay optional.

**Do not:** Require filling every slot. Do not add ST* wrapper widgets.

## D10 — Typed extras + optional JSON generate

**Choice:** `STExtra` with `kind` (button / card / container / text) on `STTheme`. JSON generator emits Dart that looks hand-written. Runtime never requires JSON.

**Why:** Apps need several button/card/text styles without a second widget family. JSON is authoring sugar; Dart is the contract. `dart:io` stays in `bin/` so `lib/` stays web-safe.

**Do not:** Load JSON at runtime. Put generate exports on the main barrel. Add Figma. Add `STCard`/`STButton`.

## D11 — Post-v1 look work is pick-one, not a dump

**Choice:** Rank later look-kit gaps in [future.md](future.md). Agents wait for [T15](tasks/T15-pick.md) before coding T16–T21.

**Why:** Production design systems still need widget states, type scale, motion, contrast checks, leftover ThemeData slots, and extra kinds. Shipping all of that at once would bloat v1 and risk duplicating scale_kit (spacing, `.sp`).

**Do not:** Implement T16–T21 together. Add spacing/padding scale, FontConfig, `STButton`/`STCard`, seed-first default, Figma runtime, or Cupertino unless the split is explicitly changed.

## D8 — Spec over README for agents

**Choice:** Agents read `spec/` + `spec/tasks/` + code. README is user-facing.

**Why:** Same as scale_kit. README will market; spec must stay short and true.

**Do not:** Treat README as session memory.
