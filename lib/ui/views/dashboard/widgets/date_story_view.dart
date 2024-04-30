import 'package:flutter/material.dart';
import 'package:storyapp/core/constants/constants.dart';
import 'package:storyapp/core/extenstions/date_extenstions.dart';
import 'package:storyapp/core/models/dated_stories/dated_stories.dart';
import 'package:storyapp/ui/widgets/carousel_slider.dart';
import 'package:storyapp/ui/widgets/image_view.dart';
import 'package:storyapp/ui/widgets/text_view.dart';

class DateStoryView extends StatelessWidget {
  final DatedStories datedStories;
  const DateStoryView({super.key, required this.datedStories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextView(
            datedStories.date!.getDayOfWeekOrFormattedDate(),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 330,
          child: CarouselSliderWidget(
            List.generate(
              datedStories.stories!.length,
              (index) {
                final story = datedStories.stories![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Constants.defaultBorderRadius,
                          ),
                        ),
                        height: 220,
                        width: double.maxFinite,
                        clipBehavior: Clip.hardEdge,
                        child: ImageView(
                          story.imageUrl,
                          ImageType.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextView(
                        story.title,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(height: 5),
                      TextView(
                        story.description!,
                        fontSize: 14,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                );
              },
            ),
            viewportFraction: 1,
          ),
        ),
      ],
    );
  }
}
