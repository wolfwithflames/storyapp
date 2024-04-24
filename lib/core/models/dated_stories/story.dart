import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? description;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  Story({
    this.id,
    this.title,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Story(id: $id, title: $title, description: $description, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    String? id,
    String? title,
    String? description,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}
