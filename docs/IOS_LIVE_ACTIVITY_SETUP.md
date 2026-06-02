# iOS Live Activity — Xcode setup (one-time)

The Dart side, the Swift widget code, and Info.plist are already done. These are
the **Xcode GUI steps only you can do** (adding a target can't be scripted safely).
Test on a **real iPhone (iOS 16.1+)** — Dynamic Island needs iPhone 14 Pro+.

App Group used everywhere: **`group.com.abdulsaheel.tsrtcbustracker`**

## 1. Add the Widget Extension target
1. Open `app/ios/Runner.xcworkspace` in Xcode.
2. **File → New → Target… → Widget Extension**.
3. Product name: **`GamyamWidget`**. Team: your team. **Uncheck** "Include Configuration App Intent". If there's an "Include Live Activity" checkbox, **check** it. Finish → "Activate" if prompted.
4. Set the new target's **Minimum Deployments → iOS 16.1**.

## 2. Use our Swift, drop the boilerplate
1. Xcode generated some files under `GamyamWidget/` (e.g. `GamyamWidget.swift`, bundle, Intent). **Delete** the generated `*.swift` files (Move to Trash) — they contain a second `@main` which collides.
2. Add our file: right-click the `GamyamWidget` group → **Add Files…** → select
   `app/ios/GamyamWidget/GamyamWidgetLiveActivity.swift` → **Target: GamyamWidget**.
   (It already contains the `@main` bundle.)

## 3. App Group on BOTH targets
For **Runner** and **GamyamWidget** separately:
- Select target → **Signing & Capabilities → + Capability → App Groups**.
- Add group **`group.com.abdulsaheel.tsrtcbustracker`** (tick it).

## 4. Confirm Info.plist
`Runner/Info.plist` already has `NSSupportsLiveActivities = YES` (done). No action,
just verify it's there.

## 5. Deployment target / Podfile
- If `pod install` complains, set `platform :ios, '16.1'` in `app/ios/Podfile`
  (or at least 13.0; the widget itself is gated to 16.1). Then:
  `cd app/ios && pod install`.

## 6. Run & test
```
flutter run -d <your-iphone>
```
Then: open a bus → **Follow** → lock the phone. You should see the **Gamyam Live
Activity** on the lock screen (route, progress bar, next stop, stops-to-go),
and the **Dynamic Island** on 14 Pro+. Setting an alarm still fires the proximity
ping.

## Known limitation (be aware)
While the app is foreground/just-backgrounded the activity updates live. iOS
**suspends apps in the background**, so for the card to keep ticking when the
phone's been idle a while, you need **ActivityKit push updates (APNs)** from a
server — that's planned for the Cloudflare proxy (`docs/ROADMAP.md`). The card
still stays on the lock screen showing the last state in the meantime.

## Data contract (Flutter → widget)
Keys written to the shared App Group (see `live_activity_service.dart`),
read in Swift via `context.attributes.prefixedKey(key)`:
`title` (String), `nextStop` (String), `speed` (Int km/h),
`progress` (Int 0–100), `stopsLeft` (Int, −1 = none), `status` (String).
