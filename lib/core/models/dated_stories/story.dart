import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? description;
  String? imageUrl;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Story({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'Story(id: $id, title: $title, description: $description, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, imageUrl: $imageUrl)';
  }

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
