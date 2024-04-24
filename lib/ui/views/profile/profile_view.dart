import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storyapp/core/utils/firebase_utils/firebase_utils.dart';
import 'package:storyapp/ui/widgets/text_view.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Center(
              child: Text("Profile"),
            ),
            TextButton(
              onPressed: FirebaseUtils.instance.logOut,
              child: const TextView("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
