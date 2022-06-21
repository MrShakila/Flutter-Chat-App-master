part of 'objects.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel {
  String senderId;
  String senderName;
  String reciverId;
  String messege;
  String id;
  String massegetime;

  MessageModel({
    required this.id,
    required this.massegetime,
    required this.messege,
    required this.reciverId,
    required this.senderId,
    required this.senderName,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
