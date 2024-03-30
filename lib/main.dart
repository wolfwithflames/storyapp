import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:storyapp/screens/camera_screen.dart';

import 'router/router.dart';
import 'screens/main_nav/main_nav_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  final rootRouter = AppRouter();
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: rootRouter.config(),
      builder: (_, router) {
        return router ?? const FlutterLogo();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavPage(),
    );
  }
}
