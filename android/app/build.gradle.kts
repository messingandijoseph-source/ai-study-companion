plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    // This activates the Firebase plugin defined in your settings.gradle.kts
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.ai_study_companion"
    // UPGRADE: 35 -> 36
    compileSdk = 36 
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.ai_study_companion"
        minSdk = flutter.minSdkVersion 
        // UPGRADE: 35 -> 36
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        multiDexEnabled = true 
    }
   

    buildTypes {
        release {
            // Using debug keys so 'flutter run --release' works immediately
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // 1. Library for modern Java feature support (Notifications fix)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // 2. Firebase Implementation using BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.8.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-messaging")
}

// Final safety application of the Google Services plugin
apply(plugin = "com.google.gms.google-services")
