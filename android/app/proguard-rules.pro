# Keep rules for R8 (isMinifyEnabled). Flutter's engine rules are applied
# automatically; these cover plugins that use reflection / Gson.

# --- Flutter ---
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# --- flutter_local_notifications (Gson models via reflection) ---
-keep class com.dexterous.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep generic signatures of Gson-serialized model classes.
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# --- flutter_foreground_task (task handler resolved by name) ---
-keep class com.pravera.** { *; }

# --- geolocator ---
-keep class com.baseflow.geolocator.** { *; }

# --- floating (Android PiP) ---
-keep class eu.wroblewscy.** { *; }

# --- Play Core (used by some plugins; avoid stripping warnings) ---
-dontwarn com.google.android.play.core.**
