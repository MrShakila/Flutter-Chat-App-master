part of 'objects.dart';



@JsonSerializable(explicitToJson: true)
class ConverstionModel {
  final String id;
  final List users;
  final List<UserModel>userarray;
 final String lastMessege;
 final String lastmessgetime;
  
 
  final String createdBy;

  ConverstionModel( {required this.createdBy,required this.id, required this.users, 
  required this.userarray, required this.lastMessege, required this.lastmessgetime});

  factory ConverstionModel.fromJson(Map<String, dynamic> json) =>
      _$ConverstionModelFromJson(json);

 

  Map<String, dynamic> toJson() => _$ConverstionModelToJson(this);
}
