import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:storyapp/widgets/edit_text.dart';
import 'package:storyapp/widgets/image_view.dart';
import 'package:storyapp/widgets/text_view.dart';

import '../../../widgets/raised_button.dart';

@RoutePage()
class AddStoryScreen extends StatefulWidget {
  final Media? media;
  const AddStoryScreen({super.key, this.media});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 15),
        )
      ],
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          EditText(
            hint: "Title",
          ),
          const SizedBox(height: 20),
          EditText(
            hint: "Story in detail",
            maxLines: 3,
            minLines: 3,
          ),
          const SizedBox(height: 20),
          if (widget.media != null)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: ImageView(
                widget.media!.file!.path,
                ImageType.file,
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
