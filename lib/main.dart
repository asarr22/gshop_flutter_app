import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gshopp_flutter/app.dart';
import 'package:gshopp_flutter/common/firebase_services/auth_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// -- Firebase Initialization
  if (kIsWeb || Platform.isAndroid) {
    await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyCbhABIvboefPSJBx4pVbEnm983DAoU53g",
                appId: "1:78101443712:web:307957382c4c1716462265",
                messagingSenderId: "78101443712",
                projectId: "g-tech-app-466c4"))
        .then(
      (FirebaseApp value) => Get.put(FirebaseAuthService()),
    );
  } else {
    await Firebase.initializeApp().then(
      (FirebaseApp value) => Get.put(FirebaseAuthService()),
    );
  }

  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // init Get Storage
  await GetStorage.init();

  // init Firebase Cloud Storage
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}
