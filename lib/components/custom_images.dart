import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletons/skeletons.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    Key? key,
    required this.svgName,
    this.color,
  }) : super(key: key);

  final String svgName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$svgName.svg",
      color: color,
    );
  }
}

class CustomNetWorkImage extends StatelessWidget {
  const CustomNetWorkImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.fit,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
       loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: width,
              height: height,
            ),
          );
        },
    );
  }
}

class CustomCircularNetworkImage extends StatelessWidget {
  const CustomCircularNetworkImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.fit,
  }) : super(key: key);

  final String url;
  final double width;
  final double height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: width,
              height: height,
            ),
          );
        },
      ),
    );
  }
}
