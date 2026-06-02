# Gamyam (TGSRTC) — Design System MASTER

> Source of truth for the rebuilt app. Generated via `ui-ux-pro-max --design-system`
> ("Accessible & Ethical", WCAG-AAA) and tuned for a government public-transit context.
> Flutter `ThemeData` tokens derived from this file live in `lib/core/theme/`.

## Design principles (fixing the old app)
1. **Accessible first** — WCAG AAA. High contrast, ≥16px body text, visible focus, 44×44 touch targets, screen-reader labels, no color-only meaning.
2. **State you can trust** — every async action has explicit loading / empty / error / success states. No frozen screens, no silent failures (the old app's core sin).
3. **Calm, legible, civic** — trustworthy transit aesthetic; clarity over decoration. Avoid complex shadows, 3D, gimmicks.
4. **Live data honesty** — show data freshness (last-updated time) and GPS staleness explicitly on the bus map.

## Color tokens
| Role | Hex | Usage |
|------|-----|-------|
| primary | `#2563EB` | brand, primary CTAs, active nav, selected bus |
| onPrimary | `#FFFFFF` | text/icons on primary |
| secondary | `#0891B2` | secondary actions, route lines, info |
| accent | `#EA580C` | high-emphasis CTA (Track / SOS-adjacent highlights) |
| background | `#F8FAFC` | app scaffold background |
| foreground | `#0F172A` | primary text |
| muted | `#F1F5FD` | surfaces, cards, input fills |
| border | `#E4ECFC` | dividers, outlines |
| destructive | `#DC2626` | SOS, errors, delete |
| ring | `#2563EB` | focus ring (3–4px) |

Dark mode: required (full). Use desaturated tonal variants, not inverted hex; re-verify contrast independently.

Bus status colors (from `statusStr`): Running → `#16A34A`, Idle → `#CA8A04`, Stopped → `#DC2626`, No Data → `#64748B`. Always pair with icon + label (no color-only).

## Typography
- **Headings:** Lexend (300–700)
- **Body:** Source Sans 3 (300–700)
- Base body 16px, line-height 1.5; type scale 12/14/16/18/24/32. Weight hierarchy: 600–700 headings, 500 labels, 400 body.
- Use tabular figures for ETAs, bus numbers, timers (prevent layout shift).

## Motion
- Micro-interactions 150–300ms, screen transitions ≤400ms; ease-out enter, ease-in exit.
- Animate transform/opacity only. Respect `prefers-reduced-motion` (`MediaQuery.disableAnimations`).
- Live bus marker movement: smooth-interpolate position between polls; never teleport.

## Spacing & layout
- 4/8 dp rhythm; section tiers 16/24/32/48.
- Mobile-first; breakpoints 375 / 768 / 1024. Respect safe areas; bottom nav ≤5 items.

## Anti-patterns to avoid
- Complex/multi-layer shadows, 3D effects, color-only indicators, emoji as icons (use SVG — Lucide/Heroicons via `lucide_icons`/custom), placeholder-only labels, errors shown only at top.
