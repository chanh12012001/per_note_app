// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

class AppColor {
  static const Color white_E1E1E1 = Color(0xffE1E1E1);
  static const Color white_F6F6F6 = Color(0xffF6F6F6);
  static Color white_20 = const Color(0xffFFFFFF).withOpacity(0.2);

  static const Color black_1F1F1F = Color(0xff1F1F1F);
  static Color black_1F1F1F_50 = const Color(0xff1F1F1F).withOpacity(0.5);
  static Color black_20 = const Color(0xff000000).withOpacity(0.2);

  static const Color red_C92D49 = Color(0xffC92D49);
  static const Color red_D44E65 = Color(0xffD44E65);
  static const Color red_861D2F = Color(0xff861D2F);
  static const Color red_E95740 = Color(0xffE95740);
  static Color red_861D2F_10 = const Color(0xff861D2F).withOpacity(0.1);

  static const Color pink_FAE9E7 = Color(0xffFAE9E7);
  static const Color pink_F2BEC8 = Color(0xffF2BEC8);
  static const Color pink_D871AC = Color(0xffD871AC);

  static const Color grey_737373 = Color(0xff737373);
  static Color grey_737373_10 = const Color(0xff737373).withOpacity(0.1);
  static const Color grey_A8A8A8 = Color(0xffA8A8A8);
  static const Color grey_C8C8C8 = Color(0xffC8C8C8);
  static Color grey_20 = Colors.grey.withOpacity(0.2);
  static Color grey_50 = Colors.grey.withOpacity(0.5);
  static const Color grey_DDDDDD = Color(0xffDDDDDD);
  static const Color grey_D5D3D4 = Color(0xffD5D3D4);
  static const Color grey_B3B3B3 = Color(0xffB3B3B3);
  static const Color grey_ADADAD = Color(0xffADADAD);
  static const Color grey_BFC0C3 = Color(0xffBFC0C3);
  static const Color grey_CACDD1 = Color(0xffCACDD1);
  static const Color grey_F6F6F6 = Color(0xffF6F6F6);
  static const Color grey_575757 = Color(0xff575757);

  static const Color blue_1B74E4 = Color(0xff1B74E4);

  static const Color yellow_F7BB42 = Color(0xffF7BB42);

  static const Color green_37BC9A = Color(0xff37BC9A);
  static const Color green_EBF9F5 = Color(0xffEBF9F5);

  static const Color purple_AC92ED = Color(0xffAC92ED);

  static const Color orange_FFEFD7 = Color(0xffffefd7);
  static const Color orange_FFAA02 = Color(0xffffaa02);
  static const Color green_ECFCE5 = Color(0xffECFCE5);
  static const Color green_18A51E = Color(0xff18A51E);
  static const Color red_FFE5E5 = Color(0xffFFE5E5);
  static const Color red_DE361C = Color(0xffDE361C);

  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color grey = Colors.grey;
  static const Color greybg = Color(0xff757575);
  static const Color transparent = Colors.transparent;

  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
}
