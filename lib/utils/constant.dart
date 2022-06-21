class Constant {
  static const IMAGEPATH = 'asset/images/';
  static const ICONPATH = 'asset/icons/';

  static String imageAsset(img) => "$IMAGEPATH$img";
  static String iconAsset(img) => "$ICONPATH$img";

  static const DUMMY_DESC =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled''';
}
