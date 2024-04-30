import 'package:get/state_manager.dart';
import 'package:storyapp/core/data/enums.dart';
import 'package:storyapp/core/logger/app_logger.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/core/repositories/story_repository/story_repository.dart';
import 'package:storyapp/getIt.dart';
import 'package:storyapp/ui/view_model/app_base_model.dart';

import '../../../core/data/api_response.dart';

class DashboardViewModel extends AppBaseViewModel {
  final _storyRepository = getIt<StoryRepository>();
  List<DatedStories> stories = [];

  @override
  init() async {
    getPastStories();
    return super.init();
  }

  getPastStories() async {
    final ApiResponse<List<DatedStories>> storiesResponse =
        await _storyRepository.getPastWeek();

    if (storiesResponse.status) {
      setApiResponseStatus(ApiResponseStatus.success);
      stories.assignAll(storiesResponse.data);
      notifyListeners();
    } else {
      setApiResponseStatus(ApiResponseStatus.error);
      AppLog.i(storiesResponse.message);
    }
  }

  Future<void> onRefresh() async {
    await getPastStories();
    refreshController.refreshCompleted();
  }
}
