# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.

# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Keep Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    static ** CREATOR;
}

# Keep Serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep R classes
-keep class **.R$* {
    public static <fields>;
}

# Keep custom application classes
-keep class com.ubx.malipo_agent.** { *; }

# Keep encryption related classes
-keep class * implements java.security.Key { *; }
-keep class * implements javax.crypto.SecretKey { *; }
-keep class * implements java.security.PrivateKey { *; }
-keep class * implements java.security.PublicKey { *; }

# Keep HTTP client classes
-keep class * implements java.net.HttpURLConnection { *; }
-keep class * implements okhttp3.** { *; }

# Keep JSON parsing classes
-keep class * implements com.google.gson.** { *; }
-keep class * implements org.json.** { *; }

# Keep SQLite classes
-keep class * implements android.database.sqlite.** { *; }

# Keep SharedPreferences
-keep class * implements android.content.SharedPreferences { *; }

# Keep location services
-keep class * implements android.location.** { *; }

# Keep device info
-keep class * implements android.os.Build { *; }

# Keep package info
-keep class * implements android.content.pm.PackageInfo { *; }

# Keep encryption/decryption classes
-keep class * implements javax.crypto.Cipher { *; }
-keep class * implements java.security.MessageDigest { *; }

# Keep network security
-keep class * implements javax.net.ssl.** { *; }

# Keep image processing
-keep class * implements android.graphics.** { *; }

# Keep file operations
-keep class * implements java.io.** { *; }

# Keep reflection for Flutter
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# Keep enum values
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep generic signatures
-keepattributes Signature

# Keep source file names for debugging
-keepattributes SourceFile,LineNumberTable

# Keep method names for debugging
-keepattributes MethodParameters

# Keep inner classes
-keep class * {
    @androidx.annotation.Keep *;
}

# Keep classes with @Keep annotation
-keep @androidx.annotation.Keep class * { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep JavaScript interface methods
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep WebView JavaScript interface
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep custom exceptions
-keep public class * extends java.lang.Exception

# Keep custom interfaces
-keep interface * {
    @androidx.annotation.Keep *;
}

# Keep custom annotations
-keep @interface * {
    @androidx.annotation.Keep *;
}

# Keep custom enums
-keep enum * {
    @androidx.annotation.Keep *;
}

# Keep custom fields
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom methods
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom constructors
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom static methods
-keepclassmembers class * {
    @androidx.annotation.Keep static *;
}

# Keep custom static fields
-keepclassmembers class * {
    @androidx.annotation.Keep static *;
}



# Keep custom instance methods
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom instance fields
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom instance constructors
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Keep custom instance static methods
-keepclassmembers class * {
    @androidx.annotation.Keep static *;
}

# Keep custom instance static fields
-keepclassmembers class * {
    @androidx.annotation.Keep static *;
}


# Google Play Services - Keep classes to prevent R8 errors
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Suppress warnings for missing Google Play Services classes
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task

# Keep Flutter Play Store specific classes
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager { *; }

# Keep Google Play Services location classes
-keep class com.google.android.gms.internal.location.** { *; }
-keep class com.google.android.gms.location.** { *; }

# Additional Flutter keep rules
-keep class io.flutter.embedding.engine.** { *; }
-keep class io.flutter.embedding.android.** { *; }
