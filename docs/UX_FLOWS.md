# Gamyam — UX Screen Flows

> Designed to fix the old app: confusing public-everything navigation, broken state,
> no feedback. Principles applied from `bencium-ux-designer` + `frontend-design` +
> `ui-ux-pro-max` (§Navigation, §Forms, §Accessibility).

## Information architecture (bottom nav, ≤5)
1. **Track** (home) — find & track a live bus. The primary job.
2. **Routes** — browse/search services & routes, see stops.
3. **Nearby** — stops near me on a map.
4. **More** — feedback, SOS info, language, about, settings.

No login required for browsing (matches reality: it's open transit data). Auth is only
relevant later if we add saved routes/favorites — kept local-first, optional.

## Old-app pain points → fix
| Old pain | Fix |
|---|---|
| Everything public, flat, no hierarchy | Clear 4-tab IA; one primary job per screen |
| No loading/error feedback | Every screen: loading skeleton / empty / error+retry / success |
| Can't tell if GPS is live | Explicit "updated Xs ago" + stale/No-Data badge on map |
| Booking dumps to random web portal | Clearly-labeled external handoff w/ in-app webview + back |
| State loss on navigation | Riverpod keeps search/filter/scroll state; restore on back |

## Core flow: Track a live bus ⭐
```
Track tab
  └─ City selector (default: last used / Hyderabad)        [/v3.0/city]
       └─ Two entry paths:
            A) Search by Route Number  ──┐
            B) Search Between Stops ─────┤
                 from-stop (autocomplete) + to-stop        [/v3.0/stops]
                                          │
            └─> Results list (NewBusModel/BusModel)         [/v3.0/trips/routeNumber
                 each: route, serviceType, next ETA          | betweenTwoLocations]
                  └─ tap ─> TRIP DETAIL                      [/v3.0/trips/details/{tripId}]
                       - stop sequence + polyline on map
                       - "Track live" button
                            └─> LIVE BUS MAP                 [/v2.0/vehicles/{vehicleId}]
                                 - bus marker, smooth-interpolated
                                 - polls every 5–10s, shows "updated Xs ago"
                                 - speed, status badge, next stop, helpline
```

### Live map states (explicit — the old app had none)
- **Loading:** skeleton map + shimmer card.
- **Live:** moving marker, green pulse, "updated 3s ago".
- **Stale (>60s):** amber badge "GPS delayed".
- **No Data (status=5):** grey marker at last-known + "Bus not reporting location".
- **Error:** inline retry, keep last-known position visible.
- **Offline:** banner + last cached position with timestamp.

## Routes flow
City → service list (searchable, virtualized — 38k services) → service detail → planned trips / route stops → trip detail → live map.

## Nearby flow
Ask location permission (with rationale) → map of nearby stops [/v2.0/stops/nearby] → tap stop → buses serving it.

## More flow
- **Feedback** → form (rating + category + text) → POST [/v3.0/feedback]; success toast.
- **Flag a bus** → POST [/v3.0/flagabus].
- **SOS** → confirm dialog (destructive styling) → POST [/v2.0/sos]; show helpline fallback.
- **Booking** → labeled external handoff to tsrtconline.in (in-app webview, clear "leaving app" cue).

## Cross-cutting UX rules
- Skeleton screens for any wait >300ms; never a blank screen.
- Destructive (SOS) visually separated, red, confirm-before.
- Every list item has a stable key; preserve scroll on back.
- Inputs: visible labels, inline validation on blur, errors below the field.
- All interactive elements ≥44×44, focus-ringed, screen-reader labeled.
