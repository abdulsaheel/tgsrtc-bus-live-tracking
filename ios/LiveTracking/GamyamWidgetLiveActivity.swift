//
//  GamyamWidgetLiveActivity.swift
//  TGSRTC Bus Live Tracking — Live Activity (iOS 16.1+).
//
//  Data is fed from Flutter via the `live_activities` plugin into the shared
//  App Group `group.com.abdulsaheel.tsrtcbustracker`, read here with `prefixedKey`.
//  Marker art: "Bus" (moving) / "BusStop" (halted) in Assets.xcassets.
//

import ActivityKit
import WidgetKit
import SwiftUI
import UIKit

// MUST match the plugin's LiveActivitiesAppAttributes EXACTLY (ContentState
// included) — ActivityKit pairs widget↔activity by this type. Mismatch =
// "ActivityKit.ActivityInput error 0".
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState
  public struct ContentState: Codable, Hashable {
    var appGroupId: String
  }
  var id = UUID()
}

extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String { "\(id)_\(key)" }
}

let sharedDefault = UserDefaults(suiteName: "group.com.abdulsaheel.tsrtcbustracker")!

// Monochrome palette. Status is the ONLY colour: green moving, orange halted.
private let kMoving = Color(red: 0.20, green: 0.78, blue: 0.45)   // green
private let kHalted = Color(red: 0.98, green: 0.62, blue: 0.16)   // orange
private let kStopped = Color(red: 0.93, green: 0.26, blue: 0.26)  // red

// MARK: - Snapshot read from the App Group

private struct BusSnapshot {
  let busNo: String
  let nextStop: String
  let prevStop: String
  let status: String
  let speed: Int
  let progress: Double
  let stopsLeft: Int

  /// Three states from the status text (falling back to speed).
  var stateLabel: String {
    let l = status.lowercased()
    if l.contains("stop") { return "Stopped" }
    if l.contains("idle") || l.contains("halt") { return "Halted" }
    if l.contains("run") || l.contains("mov") || speed > 0 { return "Moving" }
    return "Halted"
  }
  var isHalted: Bool { stateLabel != "Moving" }
  var tint: Color {
    switch stateLabel {
    case "Moving": return kMoving
    case "Stopped": return kStopped
    default: return kHalted
    }
  }

  init(_ ctx: ActivityViewContext<LiveActivitiesAppAttributes>) {
    func s(_ k: String) -> String { sharedDefault.string(forKey: ctx.attributes.prefixedKey(k)) ?? "" }
    func i(_ k: String) -> Int { sharedDefault.integer(forKey: ctx.attributes.prefixedKey(k)) }
    busNo = s("title").isEmpty ? "Live bus" : s("title")
    nextStop = s("nextStop")
    prevStop = s("prevStop")
    status = s("status")
    speed = i("speed")
    progress = max(0, min(1, Double(i("progress")) / 100.0))
    stopsLeft = i("stopsLeft")
  }
}

// MARK: - Status pill

@available(iOSApplicationExtension 16.1, *)
private struct StatusPill: View {
  let tint: Color
  let label: String
  var body: some View {
    HStack(spacing: 5) {
      Circle().fill(tint).frame(width: 6, height: 6)
      Text(label).font(.system(size: 11, weight: .heavy, design: .rounded))
        .foregroundStyle(tint)
    }
    .padding(.horizontal, 9).padding(.vertical, 4)
    .background(tint.opacity(0.18), in: Capsule())
  }
}

// MARK: - Road (progress rail) with the bus riding ABOVE it

@available(iOSApplicationExtension 16.1, *)
private struct RouteTrack: View {
  let progress: Double
  let halted: Bool
  var compact: Bool = false

  var body: some View {
    let mh: CGFloat = compact ? 30 : 40         // marker HEIGHT
    let mw = mh * 2.3                           // wide frame matches the bus art
    let rail: CGFloat = 5
    let dot: CGFloat = 13                        // endpoint dot diameter
    let h = mh + 8                              // container hugs the bus
    GeometryReader { geo in
      let w = geo.size.width
      let railY = h - 8                          // rail near the bottom
      let busX = mw / 2 + (w - mw) * progress     // bus centre travels L→R
      // seat the bus ON the road (wheels overlap the rail a touch)
      let busY = railY - mh / 2 + mh * 0.12
      ZStack {
        // road (base + covered, monochrome)
        Capsule().fill(.white.opacity(0.18))
          .frame(width: w, height: rail)
          .position(x: w / 2, y: railY)
        Capsule().fill(.white)
          .frame(width: max(rail, busX), height: rail)
          .position(x: max(rail, busX) / 2, y: railY)
        // endpoint markers — dark-ringed so they stay visible on the white rail
        endpointDot(filled: true, dot: dot).position(x: dot / 2 + 1, y: railY)
        endpointDot(filled: false, dot: dot).position(x: w - dot / 2 - 1, y: railY)
        // marker: bus while moving, bus-stop while halted — sits on the road
        marker(size: mh)
          .frame(width: mw, height: mh)
          .position(x: busX, y: busY)
          .animation(.spring(response: 0.7, dampingFraction: 0.82), value: progress)
      }
      .frame(height: h)
    }
    .frame(height: h)
  }

  /// Stop dot that stays visible whether it sits on covered (white) or
  /// uncovered rail: white fill + dark ring (start) / hollow dark-ringed (end).
  @ViewBuilder
  private func endpointDot(filled: Bool, dot: CGFloat) -> some View {
    ZStack {
      Circle().fill(filled ? Color.white : Color.black)
      Circle().strokeBorder(Color.black, lineWidth: 2)
      if !filled {
        Circle().fill(Color.white).frame(width: dot * 0.4, height: dot * 0.4)
      }
    }
    .frame(width: dot, height: dot)
  }

  @ViewBuilder
  private func marker(size: CGFloat) -> some View {
    if halted {
      assetOrSymbol("BusStop", symbol: "mappin.and.ellipse", flip: false, size: size)
    } else {
      // Bus art faces L; mirror so it points in the travel direction (→).
      assetOrSymbol("Bus", symbol: "bus.fill", flip: true, size: size)
    }
  }

  @ViewBuilder
  private func assetOrSymbol(_ name: String, symbol: String, flip: Bool, size: CGFloat) -> some View {
    Group {
      if UIImage(named: name) != nil {
        Image(name).resizable().scaledToFit()
          .scaleEffect(x: flip ? -1 : 1, y: 1)
      } else {
        Image(systemName: symbol).resizable().scaledToFit()
          .foregroundStyle(.white).padding(size * 0.15)
      }
    }
  }
}

// MARK: - Lock screen

@available(iOSApplicationExtension 16.1, *)
struct LockScreenView: View {
  let context: ActivityViewContext<LiveActivitiesAppAttributes>

  var body: some View {
    let s = BusSnapshot(context)
    VStack(alignment: .leading, spacing: 8) {
      // header: bus number only + status
      HStack(alignment: .center) {
        Text(s.busNo).font(.system(size: 19, weight: .heavy, design: .rounded))
          .foregroundStyle(.white).lineLimit(1)
        Spacer()
        StatusPill(tint: s.tint, label: s.stateLabel)
      }

      RouteTrack(progress: s.progress, halted: s.isHalted)

      HStack(alignment: .firstTextBaseline) {
        VStack(alignment: .leading, spacing: 1) {
          Text((s.isHalted ? "Halted at" : "Next stop").uppercased())
            .font(.system(size: 9, weight: .semibold))
            .foregroundStyle(.white.opacity(0.4)).tracking(0.5)
          Text(s.nextStop.isEmpty ? "Tracking…" : s.nextStop)
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .foregroundStyle(.white).lineLimit(1)
        }
        Spacer(minLength: 12)
        VStack(alignment: .trailing, spacing: 1) {
          if s.stopsLeft >= 0 {
            (Text("\(s.stopsLeft) ").font(.system(size: 15, weight: .heavy, design: .rounded))
              + Text(s.stopsLeft == 1 ? "stop to go" : "stops to go")
              .font(.system(size: 11, weight: .medium)))
              .foregroundStyle(.white).contentTransition(.numericText())
          }
          Text("\(s.speed) km/h").font(.system(size: 11, weight: .medium))
            .foregroundStyle(.white.opacity(0.55))
        }
      }
    }
    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
    .background(Color.black)
  }
}

// MARK: - Apple Watch tile (Smart Stack, .small activity family)

/// watchOS shows iPhone Live Activities in the Smart Stack but in a tiny tile
/// with its OWN background/tint — so this is a deliberately compact, flow-based
/// layout (no GeometryReader / absolute positioning, which collapse on watch).
@available(iOSApplicationExtension 16.1, *)
struct WatchTileView: View {
  let context: ActivityViewContext<LiveActivitiesAppAttributes>
  var body: some View {
    let s = BusSnapshot(context)
    VStack(alignment: .leading, spacing: 2) {
      Text("NEXT STOP").font(.system(size: 9, weight: .semibold))
        .foregroundStyle(.secondary).tracking(0.5)
      Text(s.nextStop.isEmpty ? "Tracking…" : s.nextStop)
        .font(.system(size: 15, weight: .semibold, design: .rounded))
        .lineLimit(2)
      Text(s.stateLabel).font(.system(size: 12, weight: .heavy, design: .rounded))
        .foregroundStyle(s.tint)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

/// Picks the layout by the ACTIVE activity family (delivered via Environment,
/// not the context). iOS 18+ — the only place that needs the new SDK.
@available(iOSApplicationExtension 18.0, *)
struct ActivityRootView: View {
  @Environment(\.activityFamily) private var family
  let context: ActivityViewContext<LiveActivitiesAppAttributes>
  var body: some View {
    switch family {
    case .small: WatchTileView(context: context)      // Apple Watch
    default: LockScreenView(context: context)          // iPhone lock screen
    }
  }
}

// MARK: - Widget + Dynamic Island

@available(iOSApplicationExtension 18.0, *)
struct GamyamWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
      ActivityRootView(context: context)
        .activityBackgroundTint(.black)
        .activitySystemActionForegroundColor(.white)
        .widgetURL(URL(string: "tgsrtc://live"))   // tap → open live screen
    } dynamicIsland: { context in
      let s = BusSnapshot(context)
      return DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          VStack(alignment: .leading, spacing: 2) {
            Text(s.busNo).font(.system(size: 15, weight: .heavy, design: .rounded))
              .foregroundStyle(.white).lineLimit(1)
            StatusPill(tint: s.tint, label: s.stateLabel)
          }
        }
        DynamicIslandExpandedRegion(.trailing) {
          VStack(alignment: .trailing, spacing: 0) {
            Text("\(s.speed)").font(.system(size: 17, weight: .heavy, design: .rounded))
              .foregroundStyle(.white).contentTransition(.numericText())
            Text("km/h").font(.system(size: 10)).foregroundStyle(.white.opacity(0.5))
          }
        }
        DynamicIslandExpandedRegion(.bottom) {
          VStack(spacing: 6) {
            RouteTrack(progress: s.progress, halted: s.isHalted, compact: true)
            HStack {
              Text(s.nextStop.isEmpty ? "Tracking…" : "Next: \(s.nextStop)")
                .font(.system(size: 12, weight: .medium)).foregroundStyle(.white)
                .lineLimit(1)
              Spacer()
              if s.stopsLeft >= 0 {
                Text("\(s.stopsLeft) stop\(s.stopsLeft == 1 ? "" : "s") to go")
                  .font(.system(size: 12, weight: .bold)).foregroundStyle(.white.opacity(0.7))
                  .contentTransition(.numericText())
              }
            }
          }
        }
      } compactLeading: {
        Circle().fill(s.tint).frame(width: 8, height: 8)
      } compactTrailing: {
        Text(s.stopsLeft >= 0 ? "\(s.stopsLeft)" : "\(s.speed)")
          .font(.system(size: 14, weight: .bold, design: .rounded))
          .foregroundStyle(.white).contentTransition(.numericText())
      } minimal: {
        Circle().fill(s.tint).frame(width: 8, height: 8)
      }
      .widgetURL(URL(string: "tgsrtc://live"))   // tap → open live screen
    }
    // Render this Live Activity in the Apple Watch Smart Stack too.
    .supplementalActivityFamilies([.small])
  }
}

@main
struct GamyamWidgetBundle: WidgetBundle {
  var body: some Widget {
    if #available(iOS 18.0, *) {
      GamyamWidgetLiveActivity()
    }
  }
}
