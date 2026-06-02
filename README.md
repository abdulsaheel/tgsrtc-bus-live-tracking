# TGSRTC Bus Live Tracking

A clean, fast, **unofficial** live bus-tracking app for Telangana (TGSRTC),
built with Flutter.

> ⚠️ **Unofficial & not affiliated** with TGSRTC. Bus data comes from public
> tracking feeds and may be inaccurate or delayed. Not for emergency use.

## Features
- Live bus location on a map (route polyline, stop markers, heading-rotated bus).
- Find buses by **route number** or **between two stops** (City / District / Airport).
- **Nearby stops** with walking directions.
- **Follow a bus** — persistent notification with progress (Android) / Live Activity (iOS 16.1+).
- **Proximity alarm** — get notified when your bus is ~1 km from your stop.

## Stack
Flutter · Riverpod · go_router · Dio · flutter_map (OpenStreetMap/CARTO tiles) ·
flutter_foreground_task · live_activities.

## Setup
1. `flutter pub get`
2. Copy `.env.example` → `.env` and fill in your own Mappls InTouch API
   credentials (`MAPPLS_CLIENT_ID`, `MAPPLS_CLIENT_SECRET`). **Never commit `.env`.**
3. `dart run build_runner build --delete-conflicting-outputs`
4. `flutter run`

iOS Live Activity needs a one-time Xcode Widget Extension setup — see
`docs/IOS_LIVE_ACTIVITY_SETUP.md`.

## Notes
- API credentials live only in `.env` (gitignored). The app is built so a single
  base-URL switch can route all traffic through a server-side proxy, keeping keys
  off the client for any real release.
