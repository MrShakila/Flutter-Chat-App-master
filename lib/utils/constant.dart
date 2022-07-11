class Constant {
  static const iMAGEPATH = 'asset/images/';
  static const iCONPATH = 'asset/icons/';

  static String imageAsset(img) => "$iMAGEPATH$img";
  static String iconAsset(img) => "$iCONPATH$img";

  static const dummy =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled''';
}
