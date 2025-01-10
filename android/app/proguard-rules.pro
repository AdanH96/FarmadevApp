# Mantener las clases de ML Kit
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Mantener las clases relacionadas con Firebase (si usas Firebase)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**