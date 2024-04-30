import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:storyapp/ui/views/add_story/add_story_view_model.dart';
import 'package:storyapp/ui/widgets/edit_text.dart';
import 'package:storyapp/ui/widgets/image_view.dart';
import 'package:storyapp/ui/widgets/text_view.dart';

import '../../widgets/raised_button.dart';

@RoutePage()
class AddStoryScreen extends StatelessWidget {
  final Media? media;
  const AddStoryScreen({super.key, this.media});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddStoryViewModel>.reactive(
      viewModelBuilder: () => AddStoryViewModel()..init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const TextView(
              'Submit today\'s story',
              fontSize: 16,
            ),
            centerTitle: true,
          ),
          persistentFooterButtons: [
            AppRaisedButton(
              title: "Create Story",
              onPressed: () => model.onSubmitStory(media),
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 15),
            )
          ],
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              EditText(
                hint: "Title",
                controller: model.shirshakController,
              ),
              const SizedBox(height: 20),
              EditText(
                hint: "Story in detail",
                maxLines: 3,
                minLines: 3,
                controller: model.descriptionController,
              ),
              const SizedBox(height: 20),
              if (media != null)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ImageView(
                    media!.file!.path,
                    ImageType.file,
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
