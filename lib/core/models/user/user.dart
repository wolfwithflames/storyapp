import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/api_response.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements Serializable {
  @JsonKey(name: '_id')
  String? id;
  String? firstName;
  String? lastName;
  bool? isProfileCompleted;
  dynamic profileImage;
  dynamic email;
  String? token;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.isProfileCompleted,
    this.profileImage,
    this.email,
    this.token,
  });

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, isProfileCompleted: $isProfileCompleted, profileImage: $profileImage, email: $email, token: $token)';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    bool? isProfileCompleted,
    dynamic profileImage,
    dynamic email,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      isProfileCompleted.hashCode ^
      profileImage.hashCode ^
      email.hashCode ^
      token.hashCode;
}
