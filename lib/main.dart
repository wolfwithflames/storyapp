import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storyapp/firebase_options.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/views/camera_view/camera_screen.dart';

import 'core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize getIt
  await initGetit();

  /// Initializes the Firebase app with the provided options.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Initializes the GetStorage library. For local preferences storage.
  await GetStorage.init();

  cameras = await availableCameras();
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<AppRouter>().config(),
      builder: BotToastInit(),
    ),
  );
}
