import java.io.FileInputStream
import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

fun signingProperty(name: String): String? = keystoreProperties.getProperty(name)

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "yck.kr.word_alchemy_new"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    flavorDimensions += "app"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "yck.kr.word_alchemy_new"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("dev") {
            keyAlias = signingProperty("devKeyAlias")
            keyPassword = signingProperty("devKeyPassword")
            storeFile = signingProperty("devStoreFile")?.let { file(it) }
            storePassword = signingProperty("devStorePassword")
        }

        create("prod") {
            keyAlias = signingProperty("prodKeyAlias")
            keyPassword = signingProperty("prodKeyPassword")
            storeFile = signingProperty("prodStoreFile")?.let { file(it) }
            storePassword = signingProperty("prodStorePassword")
        }
    }

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Dev단어팡")
            signingConfig = signingConfigs.getByName("dev")
        }

        create("prod") {
            dimension = "app"
            resValue("string", "app_name", "단어팡")
            signingConfig = signingConfigs.getByName("prod")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
