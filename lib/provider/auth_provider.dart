import 'package:chat_app_2/controllers/auth/auth_controlller.dart';
import 'package:chat_app_2/controllers/user/user_controller.dart';
import 'package:chat_app_2/models/objects.dart';
import 'package:chat_app_2/screens/auth/login.dart';
import 'package:chat_app_2/screens/main/home/main_screen.dart';
import 'package:chat_app_2/utils/util_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  final AuthController _authController = AuthController();
  final UserContoller _userController = UserContoller();
  late UserCredential _usercredential;
//user object
  late User _user;
// returning firebase
  User get user => _user;

  late UserModel _userModel;
// returning firebase
  UserModel get usermodel => _userModel;

//google sign in function
  Future<void> googleAuth() async {
    try {
      _usercredential = await _authController.signInWithGoogle();
      _user = _usercredential.user!;

      //save user data  in cloud firestore

      await _userController.saveUserData(
        UserModel(
            uid: _user.uid,
            img: _user.photoURL!,
            isOnline: true,
            lastSeen: DateTime.now().toString(),
            name: _user.displayName!,
            email: _user.email!),
      );

      // await fetchSingleUSer();

      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }
  //fetch single user data

  Future<void> fetchSingleUSer() async {
    try {
      _userModel = (await _userController.getUserData(_user.uid))!;
      Logger().i(_userModel.toJson());
      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _userController.updateOnlie(user.uid);
      await _authController.logout();
    } catch (e) {
      Logger().e(e);
    }
  }

  //initialize user function
  Future<void> initializedUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().w("User is currently signed out!");
        UtilFunctions.navigateTo(context, const LoginScreen());
      } else {
        Logger().w('User is signed in!', user);
        _user = user;
        await fetchSingleUSer();

        notifyListeners();
        UtilFunctions.navigateTo(context, const MainScreen());
      }
    });
  }
}
