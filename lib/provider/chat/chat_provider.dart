import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app_2/controllers/chat/chat_controller.dart';
import 'package:chat_app_2/models/objects.dart';
import 'package:chat_app_2/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../screens/main/chat/chat.dart';
import '../../utils/util_functions.dart';

class ChatProvider extends ChangeNotifier {
  final ChatContoroller _chatContoroller = ChatContoroller();

  //chat crating loader
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoader(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  late ConverstionModel _converstionModel;

  ConverstionModel get conv => _converstionModel;
  void setConv(ConverstionModel model) {
    _converstionModel = model;
    notifyListeners();
  }

  Future<void> crerateConverstions(
      UserModel peermodel, BuildContext context) async {
    try {
      //start the loader
      setLoader(true);
      //get user model
      UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).usermodel;

      _chatContoroller.checkConvExit(userModel.uid, peermodel.uid);
      //create the converstions
      _converstionModel =
          await _chatContoroller.createConverstoin(userModel, peermodel);
      notifyListeners();
      setLoader(false);
      // //finally navigate to chat screen
      UtilFunctions.navigateTo(context, Chat(convId: _converstionModel.id,));
    } catch (e) {
      Logger().e(e);
      setLoader(false);
      AwesomeDialog(
          title: "Error",
          desc: "$e",
          context: context,
          dialogType: DialogType.ERROR);
    }
  }

//send messege status

  final TextEditingController _messege = TextEditingController();
  TextEditingController get messegeController => _messege;

  Future<void> sendMessege(
    BuildContext context,
  ) async {
    try {
      if (_messege.text.isNotEmpty) {
        UserModel userModel =
            Provider.of<AuthProvider>(context, listen: false).usermodel;
        //saving user in the db
        await _chatContoroller.sendMessege(
            _converstionModel.id,
            userModel.name,
            userModel.uid,
            _converstionModel.userarray
                .firstWhere((element) => element.uid != userModel.uid)
                .uid,
            _messege.text);
        _messege.clear();
      } else {
        AwesomeDialog(
            dialogType: DialogType.WARNING,
            context: context,
            title: "Error",
            desc: "Oops!  Type A Messege First");
      }
    } catch (e) {
      Logger().e(e);
      AwesomeDialog(
          dialogType: DialogType.ERROR,
          context: context,
          title: "Error",
          desc: "$e");
    }
  }
}
