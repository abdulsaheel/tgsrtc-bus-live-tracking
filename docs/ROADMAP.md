# Gamyam — Roadmap / Planned features

## Backend (Cloudflare Worker proxy) — when built
The proxy is deferred (app currently calls Mappls directly via `AppConfig` base-URL
switch). When we build it, it should hold the Mappls credentials, cache the static
lists + OAuth token, and host:

### Multi-leg / transfer journey routing  ⭐ (decided: backend, not client)
- **Why backend:** transfer routing needs a stop→route graph for the whole network.
  Building that on the client means fetching the stop-list for all ~1,106 routes per
  city (one trip-detail call each) — impractical on-device. The routing algorithm
  (RAPTOR/CSA) also wants the full network in memory. This belongs server-side.
- **Plan:** ingest every route's stop sequence once (server cron), build the
  stop→routes graph, cache it. Expose `GET /journey?from=&to=&city=` returning
  multi-leg itineraries (e.g. "10H to Koti, change to 219").
- **Until then:** the app hands transfer trips off to Google Maps (transit deep link
  in the Plan tab) — Google already has TGSRTC's GTFS feed + a routing engine.
  Direct-bus routing stays client-side (cheap, already shipped).

## Other planned features
- **Proximity alarm** — notify when the tracked bus is within ~1 km of the user's stop.
  Builds on the live position + route data we already have.
- **Feedback / Flag-a-bus / SOS** — POST forms (endpoints already documented).
- **Trip-detail screen** — full stop sequence with per-stop ETAs.
- **Fares** — NOT available in the Mappls tracking API; would require integrating the
  TSRTC OPRS booking system (and city-bus fares are stage-based, not in any open API).
