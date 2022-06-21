import 'package:animate_do/animate_do.dart';
import 'package:chat_app_2/provider/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 3), () {
    //   // Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    //   UtilFunctions.navigateTo(context, const MainScreen());
    // });
    Provider.of<AuthProvider>(context, listen: false).initializedUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceInDown(
              child: const Icon(
                Icons.chat,
                size: 80,
                color: kWhite,
              ),
            ),
            BounceInUp(
              child: const CustomText(
                text: "CHAT APP",
                fontSize: 36,
                color: kWhite,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
