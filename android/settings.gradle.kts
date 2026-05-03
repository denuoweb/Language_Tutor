pluginManagement {
    val localProperties =
        java.util.Properties().apply {
            val localPropertiesFile = file("local.properties")
            if (localPropertiesFile.exists()) {
                localPropertiesFile.inputStream().use { this.load(it) }
            }
        }

    val flutterSdkPath = localProperties.getProperty("flutter.sdk")
    require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    val localProperties =
        java.util.Properties().apply {
            val localPropertiesFile = file("local.properties")
            if (localPropertiesFile.exists()) {
                localPropertiesFile.inputStream().use { this.load(it) }
            }
        }
    val githubToken = System.getenv("GITHUB_TOKEN") ?: localProperties.getProperty("github_token")

    repositories {
        google()
        mavenCentral()
        if (!githubToken.isNullOrBlank()) {
            maven {
                url = uri("https://maven.pkg.github.com/facebook/meta-wearables-dat-android")
                credentials {
                    username = ""
                    password = githubToken
                }
            }
        }
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // START: FlutterFire Configuration
    id("com.google.gms.google-services") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")
