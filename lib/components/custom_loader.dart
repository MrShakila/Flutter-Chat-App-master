
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key, this.color = kWhite}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: color,
      size: 35,
    );
  }
}
