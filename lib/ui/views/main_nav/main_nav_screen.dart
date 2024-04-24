import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../camera_view/camera_screen.dart';
import '../home/home_nav_screen.dart';
import 'main_nav_view_model.dart';

@RoutePage()
class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainNavVM>(
      create: (BuildContext context) => MainNavVM(),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: context.read<MainNavVM>().controller,
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            CameraScreen(),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
