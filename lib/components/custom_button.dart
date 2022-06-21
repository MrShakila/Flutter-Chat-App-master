import 'package:flutter/material.dart';
import 'custom_loader.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height = 60,
    this.isLoading = false,
    required this.color,
    required this.boxcolor,
  }) : super(key: key);

  final Color boxcolor;
  final Function() onTap;
  final String text;
  final double width;
  final double height;
  final bool isLoading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: boxcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isLoading
            ? const CustomLoader()
            : CustomText(
                text: text,
                fontSize: 25,
                color: color,
              ),
      ),
    );
  }
}
