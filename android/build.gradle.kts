// Project-level build.gradle.kts

// 1️⃣ Buildscript block — where classpath dependencies go
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.6.0") // Android Gradle plugin
        classpath("com.google.gms:google-services:4.4.0") // Google Services plugin
        classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.5") // Crashlytics plugin
    }
}

// 2️⃣ Allprojects repositories
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 3️⃣ Optional: move build directories
val newBuildDir: Directory =
    rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// 4️⃣ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}