import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storyapp/core/constants/constants.dart';
import 'package:storyapp/firebase_options.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/views/camera_view/camera_screen.dart';

import 'core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize getIt
  await initGetit();

  /// Initializes Firebase with the default options for the current platform.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  cameras = await availableCameras();
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<AppRouter>().config(),
      builder: (_, router) {
        return router ?? const FlutterLogo();
      },
      scaffoldMessengerKey: Constants.scaffoldMessengerKey,
    ),
  );
}
