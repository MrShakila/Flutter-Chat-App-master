import 'package:chat_app_2/components/custom_button.dart';
import 'package:chat_app_2/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kGreen,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: "Lets Sign In Now",
              fontSize: 36,
              color: kWhite,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              boxcolor: kOrange,
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).googleAuth();
              },
              width: 300,
              color: kWhite,
              text: "Sign In With Google",
            )
          ],
        ),
      ),
    );
  }
}
