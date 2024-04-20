import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/ui/views/splash/splash_view_model.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) async => await viewModel.init(),
      builder: (context, model, child) {
        return const Scaffold(
          body: Center(
            child: FlutterLogo(
              size: 60,
            ),
          ),
        );
      },
    );
  }
}
