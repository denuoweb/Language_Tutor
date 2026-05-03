import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties =
    Properties().apply {
        val file = rootProject.file("local.properties")
        if (file.exists()) {
            file.inputStream().use { load(it) }
        }
    }

val configuredNdkDirFromProperties = localProperties.getProperty("ndk.dir")

val configuredNdkPathOverride =
    localProperties.getProperty("apkw.ndk.path")
        ?: System.getenv("ANDROID_NDK_HOME")
        ?: System.getenv("ANDROID_NDK_ROOT")

val configuredNdkDir = configuredNdkPathOverride ?: configuredNdkDirFromProperties

val configuredAapt2Path =
    localProperties.getProperty("apkw.aapt2.path")
        ?: System.getenv("APKW_AAPT2_PATH")

val configuredNdkVersion =
    configuredNdkDir?.let { ndkDir ->
        val sourceProperties = file("$ndkDir/source.properties")
        if (!sourceProperties.exists()) {
            null
        } else {
            Properties().apply {
                sourceProperties.inputStream().use { load(it) }
            }.getProperty("Pkg.Revision")
        }
    }

if (!configuredAapt2Path.isNullOrBlank()) {
    project.extensions.extraProperties["android.aapt2FromMavenOverride"] =
        configuredAapt2Path
}

android {
    namespace = "com.denuoweb.language_tutor"
    compileSdk = flutter.compileSdkVersion
    if (!configuredNdkVersion.isNullOrBlank()) {
        if (!configuredNdkPathOverride.isNullOrBlank()) {
            ndkPath = configuredNdkPathOverride
        }
        ndkVersion = configuredNdkVersion
    } else if (configuredNdkDir.isNullOrBlank()) {
        ndkVersion = flutter.ndkVersion
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    signingConfigs {
        create("repoDebug") {
            // Keep debug installs compatible across machines by using a stable repo-local key.
            storeFile = file("language-tutor-debug.keystore")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.denuoweb.language_tutor"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("repoDebug")
        }
        release {
            // TODO: Replace with a production signing config before shipping a release build.
            signingConfig = signingConfigs.getByName("repoDebug")
        }
    }
}

flutter {
    source = "../.."
}
