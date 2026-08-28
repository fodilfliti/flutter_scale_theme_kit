# Agent skill (consumers)

Usage skill for apps that depend on `flutter_scale_theme_kit`. [Agent Skills](https://agentskills.io) format (`SKILL.md`) so Cursor, Claude Code, Codex, Copilot, and other compatible agents can load it.

Package authors: keep `spec/` for internals. When you change a public API, update `skills/flutter-scale-theme-kit/` in the same change.

## Install (any compatible agent)

```bash
npx skills add fodilfliti/flutter_scale_theme_kit
npx skills add fodilfliti/flutter_scale_theme_kit --skill flutter-scale-theme-kit
```

If the app also uses **size** (`flutter_scale_kit`, sibling package), install that skill too:

```bash
npx skills add fodilfliti/flutter_scale_kit
```

Then ask:

> Init Flutter Scale Theme Kit with defaults.
