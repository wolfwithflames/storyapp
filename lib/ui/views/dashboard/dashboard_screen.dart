import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/ui/views/dashboard/dashboard_view_model.dart';
import 'package:storyapp/ui/views/dashboard/widgets/date_story_view.dart';
import 'package:storyapp/ui/widgets/refresher_listview.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: AppRefreshListView(
              refreshController: model.refreshController,
              itemCount: model.stories.length,
              snapshotStatus: model.apiResponseStatus,
              onRefresh: model.onRefresh,
              separatorBuilder: (p0, p1) => const SizedBox(height: 10),
              padding: const EdgeInsets.only(bottom: 50),
              itemBuilder: (context, index) {
                final story = model.stories[index];
                return DateStoryView(datedStories: story);
              },
            ),
          ),
        );
      },
    );
  }
}
