# T11 — Example gallery

## Goal

One demo surface per v1 mapped widget; light/dark toggle; **zero** per-widget colors on Material widgets.

## Read first

- [../material-map.md](../material-map.md)

## Files

- `example/lib/main.dart` (extend T10)
- maybe `example/lib/gallery.dart`

## Steps

Show: Scaffold, AppBar, Card, Elevated/Filled/Outlined/Text buttons, FAB, TextField, ListTile, NavigationBar, Switch, Checkbox, chips, Divider, progress. Toggle `themeMode`. Dialog/SnackBar via buttons.

Material widgets must not set `color:` / `backgroundColor:` except where the API requires a splash (then use `context.st`).

## Tests

Example analyzes. Widget test in example optional.

## Done when

Toggling dark updates Scaffold/Card/buttons from tokens.

## Do not

Introduce STCard.
