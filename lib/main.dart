import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // This will be overridden in main
});

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

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

  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const App()));
}
