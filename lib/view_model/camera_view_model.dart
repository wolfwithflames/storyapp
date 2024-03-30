import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:storyapp/router/router.dart';

class CameraViewModel extends ChangeNotifier {
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
        onPicked: (selectedList) {
          mediaList = selectedList;
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
        mediaCount: MediaCount.single,
        mediaType: type ?? MediaType.all,
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

  routeToAddStory(BuildContext context) {
    context.router.pushNamed(Routes.addStory);
  }
}
