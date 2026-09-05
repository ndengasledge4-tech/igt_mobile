import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")

    // Le plugin Flutter doit être appliqué après
    // les plugins Android et Kotlin.
    id("dev.flutter.flutter-gradle-plugin")
}

// ============================================================
// CONFIGURATION DU KEYSTORE
// ============================================================

// Fichier contenant les informations permettant à Gradle
// d'accéder au keystore de signature.
//
// IMPORTANT :
// Ce fichier contient des informations sensibles.
// Il doit être exclu du dépôt Git via .gitignore.
val keystorePropertiesFile = rootProject.file("key.properties")

// Objet permettant de charger les propriétés du fichier.
val keystoreProperties = Properties()

// On charge key.properties uniquement s'il existe.
//
// Cela permet notamment d'éviter une erreur immédiate lors
// de certaines opérations Gradle avant la configuration
// complète de la signature.
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}


// ============================================================
// CONFIGURATION ANDROID
// ============================================================

android {

    // Namespace Kotlin/Java de l'application.
    //
    // Il correspond maintenant à l'identité Android définitive
    // de notre application.
    namespace = "com.horizondigitalafrica.igt"

    // Version du SDK Android utilisée par Flutter.
    compileSdk = flutter.compileSdkVersion

    // Version du NDK fournie/recommandée par Flutter.
    ndkVersion = flutter.ndkVersion


    // ========================================================
    // OPTIONS DE COMPILATION JAVA
    // ========================================================

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }


    // ========================================================
    // CONFIGURATION DE LA SIGNATURE
    // ========================================================

    signingConfigs {

        // Configuration utilisée pour les builds RELEASE.
        //
        // Les informations sensibles sont récupérées depuis
        // android/key.properties.
        create("release") {

            // Alias de la clé privée.
            keyAlias = keystoreProperties["keyAlias"] as String

            // Mot de passe de la clé privée.
            keyPassword = keystoreProperties["keyPassword"] as String

            // Emplacement du fichier .jks.
            storeFile = file(
                keystoreProperties["storeFile"] as String
            )

            // Mot de passe du keystore.
            storePassword = keystoreProperties["storePassword"] as String
        }
    }


    // ========================================================
    // CONFIGURATION PAR DÉFAUT DE L'APPLICATION
    // ========================================================

    defaultConfig {

        // Application ID définitif utilisé par Google Play.
        //
        // ATTENTION :
        // Cet identifiant devra rester identique après la
        // publication de l'application.
        applicationId = "com.horizondigitalafrica.igt"

        // Version minimale Android supportée.
        minSdk = flutter.minSdkVersion

        // Version Android cible.
        targetSdk = flutter.targetSdkVersion

        // Version interne Android.
        //
        // Flutter récupère cette valeur depuis pubspec.yaml.
        versionCode = flutter.versionCode

        // Version visible par l'utilisateur.
        //
        // Flutter récupère cette valeur depuis pubspec.yaml.
        versionName = flutter.versionName
    }


    // ========================================================
    // TYPES DE BUILD
    // ========================================================

    buildTypes {

        // ----------------------------------------------------
        // RELEASE
        // ----------------------------------------------------
        release {

            // Utilisation de notre véritable configuration
            // de signature au lieu de la clé DEBUG.
            signingConfig = signingConfigs.getByName("release")
        }
    }
}


// ============================================================
// CONFIGURATION KOTLIN
// ============================================================

kotlin {
    compilerOptions {
        // Kotlin utilise Java Virtual Machine 17.
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}


// ============================================================
// CONFIGURATION FLUTTER
// ============================================================

flutter {

    // Racine du projet Flutter.
    source = "../.."
}