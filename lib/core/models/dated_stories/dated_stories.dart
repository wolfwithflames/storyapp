import 'package:json_annotation/json_annotation.dart';

import 'story.dart';

part 'dated_stories.g.dart';

@JsonSerializable()
class DatedStories {
  DateTime? date;
  List<Story>? stories;

  DatedStories({this.date, this.stories});

  @override
  String toString() => 'DatedStories(date: $date, stories: $stories)';

  factory DatedStories.fromJson(Map<String, dynamic> json) {
    return _$DatedStoriesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DatedStoriesToJson(this);

  DatedStories copyWith({
    DateTime? date,
    List<Story>? stories,
  }) {
    return DatedStories(
      date: date ?? this.date,
      stories: stories ?? this.stories,
    );
  }
}
