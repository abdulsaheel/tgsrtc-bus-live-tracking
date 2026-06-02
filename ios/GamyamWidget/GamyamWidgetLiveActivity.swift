//
//  GamyamWidgetLiveActivity.swift
//  Gamyam — live bus tracking Live Activity (iOS 16.1+).
//
//  Add this file to a Widget Extension target named "GamyamWidget".
//  Data is fed from Flutter via the `live_activities` plugin into the shared
//  App Group `group.com.abdulsaheel.tsrtcbustracker`, read here with `prefixedKey`.
//  See docs/IOS_LIVE_ACTIVITY_SETUP.md for the full Xcode setup.

import ActivityKit
import WidgetKit
import SwiftUI

// The live_activities plugin pipes data through this attributes type.
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState
  public struct ContentState: Codable, Hashable {}
  var id = UUID()
}

extension LiveActivitiesAppAttributes {
  func prefixedKey(_ key: String) -> String { "\(id)_\(key)" }
}

// Shared store written by the Flutter side (must match the App Group id).
let sharedDefault = UserDefaults(suiteName: "group.com.abdulsaheel.tsrtcbustracker")!

// Brand colours (mirror lib/core/theme/app_colors.dart).
private let kPrimary = Color(red: 0.145, green: 0.388, blue: 0.922) // #2563EB
private let kSecondary = Color(red: 0.031, green: 0.569, blue: 0.698) // #0891B2

@available(iOSApplicationExtension 16.1, *)
struct GamyamWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
      LockScreenView(context: context)
        .padding(16)
        .activityBackgroundTint(Color.black.opacity(0.85))
        .activitySystemActionForegroundColor(.white)
    } dynamicIsland: { context in
      let title = sharedDefault.string(forKey: context.attributes.prefixedKey("title")) ?? "Live bus"
      let nextStop = sharedDefault.string(forKey: context.attributes.prefixedKey("nextStop")) ?? ""
      let speed = sharedDefault.integer(forKey: context.attributes.prefixedKey("speed"))
      let progress = Double(sharedDefault.integer(forKey: context.attributes.prefixedKey("progress"))) / 100.0
      let stopsLeft = sharedDefault.integer(forKey: context.attributes.prefixedKey("stopsLeft"))

      return DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Label(title, systemImage: "bus.fill").font(.headline).foregroundStyle(.white)
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("\(speed) km/h").font(.subheadline).foregroundStyle(.white.opacity(0.7))
        }
        DynamicIslandExpandedRegion(.bottom) {
          VStack(alignment: .leading, spacing: 6) {
            ProgressView(value: progress).tint(kSecondary)
            HStack {
              Text(nextStop.isEmpty ? "Tracking…" : "Next: \(nextStop)")
                .font(.footnote).foregroundStyle(.white)
              Spacer()
              if stopsLeft >= 0 {
                Text("\(stopsLeft) stop\(stopsLeft == 1 ? "" : "s") to go")
                  .font(.footnote).foregroundStyle(kSecondary)
              }
            }
          }
        }
      } compactLeading: {
        Image(systemName: "bus.fill").foregroundStyle(kSecondary)
      } compactTrailing: {
        Text(stopsLeft >= 0 ? "\(stopsLeft)" : "\(speed)")
          .foregroundStyle(.white)
      } minimal: {
        Image(systemName: "bus.fill").foregroundStyle(kSecondary)
      }
    }
  }
}

@available(iOSApplicationExtension 16.1, *)
struct LockScreenView: View {
  let context: ActivityViewContext<LiveActivitiesAppAttributes>

  var body: some View {
    let title = sharedDefault.string(forKey: context.attributes.prefixedKey("title")) ?? "Live bus"
    let nextStop = sharedDefault.string(forKey: context.attributes.prefixedKey("nextStop")) ?? ""
    let status = sharedDefault.string(forKey: context.attributes.prefixedKey("status")) ?? ""
    let speed = sharedDefault.integer(forKey: context.attributes.prefixedKey("speed"))
    let progress = Double(sharedDefault.integer(forKey: context.attributes.prefixedKey("progress"))) / 100.0
    let stopsLeft = sharedDefault.integer(forKey: context.attributes.prefixedKey("stopsLeft"))

    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Image(systemName: "bus.fill").foregroundStyle(kSecondary)
        Text(title).font(.headline).fontWeight(.bold).foregroundStyle(.white)
          .lineLimit(1)
        Spacer()
        Text(status.isEmpty ? "Live" : status)
          .font(.caption).fontWeight(.semibold)
          .padding(.horizontal, 8).padding(.vertical, 3)
          .background(kSecondary.opacity(0.25), in: Capsule())
          .foregroundStyle(kSecondary)
      }

      ProgressView(value: progress).tint(kSecondary)

      HStack(alignment: .firstTextBaseline) {
        VStack(alignment: .leading, spacing: 2) {
          Text(nextStop.isEmpty ? "Tracking…" : "Next stop").font(.caption2)
            .foregroundStyle(.white.opacity(0.5))
          Text(nextStop.isEmpty ? " " : nextStop).font(.subheadline).fontWeight(.semibold)
            .foregroundStyle(.white).lineLimit(1)
        }
        Spacer()
        VStack(alignment: .trailing, spacing: 2) {
          if stopsLeft >= 0 {
            Text("\(stopsLeft) stop\(stopsLeft == 1 ? "" : "s") to go")
              .font(.subheadline).fontWeight(.bold).foregroundStyle(kSecondary)
          }
          Text("\(speed) km/h").font(.caption).foregroundStyle(.white.opacity(0.6))
        }
      }
    }
  }
}

// Widget bundle entry point. If Xcode generated its own @main bundle file,
// delete that file (only one @main may exist).
@main
struct GamyamWidgetBundle: WidgetBundle {
  var body: some Widget {
    if #available(iOS 16.1, *) {
      GamyamWidgetLiveActivity()
    }
  }
}
