import 'package:chat_app_2/models/objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class ChatContoroller {
  // Firestore instance create
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a collection refferance
  CollectionReference converstions =
      FirebaseFirestore.instance.collection('converstions');
//create messege ollections
  CollectionReference messegeCollections =
      FirebaseFirestore.instance.collection('messeges');
  // Create a converstion information
  Future<ConverstionModel> createConverstoin(
      UserModel user, UserModel peeruser) async {
    ConverstionModel? model = await checkConvExit(user.uid, peeruser.uid);
    Logger().wtf({"model is": model});
    if (model == null) {
      //generarte random id
      String docId = converstions.doc().id;
      await converstions
          .doc(docId)
          .set({
            'id': docId,
            'users': [user.uid, peeruser.uid],
            'userarray': [user.toJson(), peeruser.toJson()],
            'lastMessege': "Start A Converstion",
            'lastmessgetime': DateTime.now().toString(),
            'createdBy': user.uid,
            'createdAt': DateTime.now().toString()
          })
          .then((value) => Logger().i("Converstion Added"))
          .catchError(
              (error) => Logger().e("Failed to add converstion: $error"));
      DocumentSnapshot snapshot = await converstions.doc(docId).get();
      return ConverstionModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      return model;
    }
  }

//check if the converstion is in already in the db
  Future<ConverstionModel?> checkConvExit(String userid, String peerid) async {
    try {
      ConverstionModel? model;
      QuerySnapshot temp = await converstions
          .where('users', arrayContainsAny: [userid, peerid]).get();
      Logger().d(temp.docs.length);
//checkingf the retrive
      for (var item in temp.docs) {
        var tempModel =
            ConverstionModel.fromJson(item.data() as Map<String, dynamic>);

        if (tempModel.users.contains(userid) &&
            tempModel.users.contains(peerid)) {
          Logger().d('Converstion Exits');
          model = tempModel;
        } else {
          Logger().d('Converstion is not Exits');
          model = null;
        }
      }
      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
  //retrive converstions

  Stream<QuerySnapshot> getConverstions(String uid) {
    return converstions
        .orderBy('createdAt', descending: true)
        .where('users', arrayContainsAny: [uid]).snapshots();
  }

  //-------------send retrive Massege

  Future<void> sendMessege(
    String conidid,
    String senderName,
    String senderId,
    String reciverid,
    String messege,
  ) async {
    try {
      await messegeCollections.add({
        'id': conidid,
        'senderName': senderName,
        'senderId': senderId,
        'reciverId': reciverid,
        'messege': messege,
        'massegetime': DateTime.now().toString(),
        'createdAt': DateTime.now(),
      });
      await converstions.doc(conidid).update({
        'lastMessege': messege,
        'lastmessgetime': DateTime.now().toString(),
        'createdAt': DateTime.now().toString()
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  Stream<QuerySnapshot> getMesseges(String convid) {
    return messegeCollections
        .orderBy('createdAt', descending: true)
        .where('id',isEqualTo: convid).snapshots();
  }
}
