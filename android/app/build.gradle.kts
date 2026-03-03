plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

android {
    namespace = "com.example.sample"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.sample"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true

        }
    }

    flavorDimensions += "flavour-type"
    productFlavors {
        create("prod") {
            dimension = "flavour-type"
            applicationId = "com.example.sample"
            resValue ("string", "app_name", "Movie")
        }
        create("sit")  {
            dimension = "flavour-type"
            applicationId = "com.example.sample_sit"
            resValue  ("string", "app_name", "Movie SIT")
        }
        create("uat")  {
            dimension = "flavour-type"
            applicationId = "com.example.sample_uat"
            resValue ("string", "app_name", "Movie UAT")
        }
    }
}
dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")
    implementation("com.google.firebase:firebase-crashlytics-ktx:18.3.6")
    implementation("com.google.android.material:material:1.11.0")
    implementation("com.google.firebase:firebase-analytics-ktx:21.3.0")
}
flutter {
    source = "../.."
}
