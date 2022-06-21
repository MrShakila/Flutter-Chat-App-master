import 'package:chat_app_2/models/objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class UserContoller {
  // Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a collection refferance
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Save user information
  Future<void> saveUserData(UserModel model) {
    return users
        .doc(model.uid)
        .set(model.toJson())
        .then((value) => Logger().i("User Added"))
        .catchError((error) => Logger().e("Failed to add user: $error"));
  }

  Future<void> updateOnlie(String uid) {
    return users
        .doc(uid)
        .update({'isOnline': false, 'lastSeen': DateTime.now().toString()})
        .then((value) => Logger().i("Online Status Updated "))
        .catchError((error) => Logger().e("Failed to upadte online status : $error"));
  }

  //get user data
  Future<UserModel?> getUserData(String id) async {
    try {
      DocumentSnapshot snapshot = await users.doc(id).get();
      // Logger().i(snapshot.data());
      UserModel userModel =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      Logger().d(userModel.name);

      return userModel;
    } catch (e) {
      Logger().e(e);
    }
    return null;
  }

  //retrive user string

  Stream<QuerySnapshot> getUsers(String uid) {
    return users.where('uid', isNotEqualTo: uid).snapshots();
  }
}
