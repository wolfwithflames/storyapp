import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storyapp/view_model/camera_view_model.dart';
import 'package:storyapp/view_model/main_nav_view_model.dart';
import 'package:storyapp/widgets/text_view.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) {
      controller = CameraController(cameras[0], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    if (cameras.isNotEmpty) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameras.isEmpty) {
      return const Center(
        child: TextView("No camera found"),
      );
    }
    if (!controller.value.isInitialized) {
      return Container();
    }
    return ChangeNotifierProvider<CameraViewModel>(
      create: (context) => CameraViewModel(),
      builder: (context, child) => GestureDetector(
        onVerticalDragUpdate: (details) {
          int sensitivity = 12;
          if (details.delta.dy < -sensitivity) {
            context.read<CameraViewModel>().openImagePicker(context);
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            CameraPreview(controller),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                onPressed: () {
                  context.read<CameraViewModel>().routeToAddStory(context);
                },
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
                    onPressed: () => context.read<MainNavVM>().changePage(1),
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
  }
}
