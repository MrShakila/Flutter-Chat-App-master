// GENERATED CODE - DO NOT MODIFY BY HAND

part of objects;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConverstionModel _$ConverstionModelFromJson(Map<String, dynamic> json) =>
    ConverstionModel(
      createdBy: json['createdBy'] as String,
      id: json['id'] as String,
      users: json['users'] as List<dynamic>,
      userarray: (json['userarray'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessege: json['lastMessege'] as String,
      lastmessgetime: json['lastmessgetime'] as String,
    );

Map<String, dynamic> _$ConverstionModelToJson(ConverstionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'users': instance.users,
      'userarray': instance.userarray.map((e) => e.toJson()).toList(),
      'lastMessege': instance.lastMessege,
      'lastmessgetime': instance.lastmessgetime,
      'createdBy': instance.createdBy,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String,
      massegetime: json['massegetime'] as String,
      messege: json['messege'] as String,
      reciverId: json['reciverId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'reciverId': instance.reciverId,
      'messege': instance.messege,
      'id': instance.id,
      'massegetime': instance.massegetime,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      img: json['img'] as String,
      isOnline: json['isOnline'] as bool,
      lastSeen: json['lastSeen'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'lastSeen': instance.lastSeen,
      'isOnline': instance.isOnline,
      'img': instance.img,
    };
