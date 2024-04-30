import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/getIt.dart';

import '../../../core/logger/app_logger.dart';
import 'camera_screen.dart';

class CameraViewModel extends BaseViewModel {
  late CameraController camController;

  Future<Media?> openImagePicker(BuildContext context,
      {MediaType? type}) async {
    List<Media> mediaList = [];
    showBottomSheet(
      context: context,
      enableDrag: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 100,
      ),
      builder: (context) => MediaPicker(
        mediaList: mediaList,
        onPicked: (selectedList) async {
          mediaList = selectedList;
          if (mediaList.isNotEmpty) {
            await routeToAddStory(media: mediaList.first);
            Navigator.pop(context);
          }
        },
        onCancel: () => Navigator.pop(context),
        mediaCount: MediaCount.single,
        mediaType: type ?? MediaType.image,
        decoration: PickerDecoration(
          blurStrength: 0,
          scaleAmount: 1,
          counterBuilder: (context, index) {
            if (index == null) return const SizedBox.shrink();
            return Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
    );
    return null;
  }

  Future<void> routeToAddStory({Media? media}) async {
    await getIt<AppRouter>().push(AddStoryRoute(media: media));
  }

  onCameraCapture() async {
    try {
      final XFile capturedImage = await camController.takePicture();
      Media media = Media(
        id: "captured_${DateTime.now().microsecondsSinceEpoch}",
        file: File(capturedImage.path),
        creationTime: DateTime.now(),
      );
      routeToAddStory(media: media);
    } on CameraException catch (e) {
      AppLog.e(e);
    }
  }

  init() {
    if (cameras.isNotEmpty) {
      camController = CameraController(cameras[0], ResolutionPreset.max);
      camController.initialize().then((_) {
        notifyListeners();
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
    super.dispose();
    if (cameras.isNotEmpty) {
      camController.dispose();
    }
  }
}
