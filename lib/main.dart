import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  // Firebase Initialization
  if (kIsWeb || Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCbhABIvboefPSJBx4pVbEnm983DAoU53g",
            appId: "1:78101443712:web:307957382c4c1716462265",
            messagingSenderId: "78101443712",
            projectId: "g-tech-app-466c4"));
  } else {
    await Firebase.initializeApp();
  }

  // Setup ProviderContainer
  final container = ProviderContainer(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ]);

  // Access FirebaseAuthService through the container
  final firebaseAuthService = container.read(firebaseAuthServiceProvider);

  // Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // init Firebase Cloud Storage
  await Firebase.initializeApp();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );

  // Execute initial setup logic
  await firebaseAuthService.initialSetup();
}
