import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:storyapp/core/data/api_response.dart';
import 'package:storyapp/core/models/dated_stories/story.dart';
import 'package:storyapp/core/repositories/story_repository/story_repository.dart';
import 'package:storyapp/core/router/router.dart';
import 'package:storyapp/core/utils/firebase_utils/firebase_utils.dart';
import 'package:storyapp/core/utils/pref_utils.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';
import 'package:storyapp/ui/widgets/toast.dart';

import '../../../getIt.dart';

class AddStoryViewModel extends AppBaseViewModel {
  final _storyRepository = getIt<StoryRepository>();

  final shirshakController = TextEditingController();
  final descriptionController = TextEditingController();

  onSubmitStory(Media? media) async {
    if (media != null && media.file != null) {
      BotToast.showLoading();
      String? imageUrl = await FirebaseUtils.instance.uploadFile(
        file: media.file,
        path: "story",
        fileName:
            "${PrefsUtils.getUserData()!.id}_${DateTime.now().millisecondsSinceEpoch}",
      );
      if (imageUrl != null) {
        final ApiResponse<Story> storyResponse =
            await _storyRepository.addStory(
          title: shirshakController.text,
          description: descriptionController.text,
          imageUrl: imageUrl,
        );
        BotToast.closeAllLoading();

        if (storyResponse.status) {
          getIt<AppRouter>().maybePop<bool>(true);
        } else {
          botToast(storyResponse.message);
        }
      } else {
        BotToast.closeAllLoading();
      }
    }
    return;
  }

  @override
  init() {
    super.init();
    if (kDebugMode) {
      shirshakController.text = "Hello World";
      descriptionController.text =
          "Lorem ipsum dolor sit amet, consect et nisl. Lorem ipsum dolor sit amet, consect et nisl. Lorem ipsum dolor sit am";
    }
  }
}
