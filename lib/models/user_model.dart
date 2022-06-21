part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  String uid;

  String name;
  String email;
  String lastSeen;
  bool isOnline;
  String img;

  UserModel({
    required this.uid,
    required this.img,
    required this.isOnline,
    required this.lastSeen,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
