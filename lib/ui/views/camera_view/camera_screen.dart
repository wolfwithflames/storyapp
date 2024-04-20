import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/ui/views/camera_view/camera_view_model.dart';
import 'package:storyapp/ui/views/main_nav/main_nav_view_model.dart';
import 'package:storyapp/widgets/text_view.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraViewModel>.reactive(
      viewModelBuilder: () => CameraViewModel(),
      onViewModelReady: (viewModel) async => await viewModel.init(),
      builder: (context, model, child) {
        if (cameras.isEmpty) {
          return const Center(
            child: TextView("No camera found"),
          );
        }
        if (!model.camController.value.isInitialized) {
          return Container();
        }
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) => context.read<MainNavVM>().changePage(1),
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              int sensitivity = 12;
              if (details.delta.dy < -sensitivity) {
                context.read<CameraViewModel>().openImagePicker(context);
              }
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(model.camController),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: model.onCameraCapture,
                    icon: const Icon(
                      Icons.fiber_manual_record_sharp,
                      color: Colors.white,
                      size: 120,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () =>
                            context.read<MainNavVM>().changePage(1),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
