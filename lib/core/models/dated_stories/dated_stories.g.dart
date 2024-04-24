// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dated_stories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatedStories _$DatedStoriesFromJson(Map<String, dynamic> json) => DatedStories(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      stories: (json['stories'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatedStoriesToJson(DatedStories instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'stories': instance.stories,
    };
