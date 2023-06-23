// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:per_note/config/colors.dart';
import 'package:per_note/config/dimens.dart';
import 'package:per_note/config/fonts.dart';

enum TextStyleApp {
  defaut_s8_w8_white,
  defaut_s9_w5_grey737373,
  defaut_s9_w5_green37BC9A,
  defaut_s9_w5_red_C92D49,
  defaut_s10_w7_red_C92D49,
  defaut_s10_w4_white,
  defaut_s10_bold_black,
  defaut_s10_w4_redC92D49,
  defaut_s10_w4_grey737373,
  defaut_s11_w4_red_C92D49,
  defaut_s11_w5_red_C92D49,
  defaut_s11_w4_red_861D2F,
  defaut_s11_w4_grey737373,
  defaut_s11_w5_grey737373_through,
  defaut_s12_normal_grey737373,
  defaut_s13_bold_black,
  defaut_s14_w6_white,
  defaut_s14_w6_black1F1F1F,
  defaut_s14_w4_black1F1F1F,
  defaut_s14_w8_black1F1F1F,
  defaut_s14_normal_grey737373,
  defaut_s14_w4_grey737373,
  defaut_s14_w5_grey737373,
  defaut_s14_w6_grey737373,
  defaut_s14_w4_red_861D2F,
  defaut_s14_w8_white,
  defaut_s14_w8_redC92D49,
  defaut_s14_w6_redC92D49,
  defaut_s15_w4_grey737373,
  defaut_s15_w7_redC92D49,
  defaut_s15_w8_black1F1F1F,
  defaut_s16_w8_redC92D49,
  defaut_s16_w7_black1F1F1F,
  defaut_s17_w3_black1F1F1F,
  defaut_s16_w7_white,
  inter_s16_w6Thin_black1F1F1F,
  defaut_s18_w8_redC92D49,
  defaut_s18_w8_black1F1F1F,
  defaut_s18_w6_black1F1F1F,
  defaut_s16_w4_grey737373,
  interSemiBold_s18_w6_black1F1F1F,
  interSemiBold_s18_w6_white,
  interSemiBold_s18_w6_grey575757,
  interSemiBold_s16_w6_grey575757,
  interSemiBold_s14_w6_grey575757,
  interSemiBold_s14_w6_greyC8C8C8,
  interSemiBold_s14_w6_black1F1F1F,
  interSemiBold_s14_w6_green37BC9A,
  interSemiBold_s14_w6_redC92D49,
  interSemiBold_s14_w6_white,
  interSemiBold_s10_w6_redC92D49,
  interSemiBold_s11_w6_redC92D49,
  interSemiBold_s12_w6_redC92D49,
  interSemiBold_s12_w6_grey737373,
  interSemiBold_s10_w6_black1F1F1F,
  interSemiBold_s11_w6_black1F1F1F,
  interSemiBold_s12_w6_black1F1F1F,
  interSemiBold_s12_w6_white,
  interSemiBold_s16_w6_redC92D49,
  interSemiBold_s16_w6_black1F1F1F,
  interRegular_s14_w4_grey575757,
  interRegular_s12_w4_grey575757,
  interRegular_s12_w4_white,
  interRegular_s12_w4_black1F1F1F,
  interRegular_s12_w4_redC92D49,
  interRegular_s16_w4_black1F1F1F,
  interRegular_s14_w4_black1F1F1F,
  interRegular_s16_w4_grey737373,
  interRegular_s16_w4_greyCACDD1,
  interRegular_s10_w4_grey575757,
  interRegular_s10_w4_green37BC9A,
  interRegular_s10_w4_redC92D49,
  interRegular_s11_w4_grey575757,
  inter_s24_bold_black1F1F1F,
  interBold_s16_w7_redC92D49,
  interBold_s14_w7_redC92D49,
  interBold_s14_w7_black1F1F1F,
  interBold_s16_w7_black1F1F1F,
  interBold_s24_black1F1F1F,
  interBold_s18_w7_black1F1F1F,
  inter_s14_w4_black1F1F1F,
  defaut_s16_w6_redC92D49,
  defaut_s12_w4_grey737373,
  defaut_s12_w4_black1F1F1F,
  defaut_s12_w4_white,
  defaut_s10_w6_white,
  defaut_s12_w6_white,
  defaut_s10_w4_black1F1F1F,
  defaut_s10_w4_grey737373_line,
  defaut_s12_w6_black1F1F1F,
  defaut_s12_w4_red_C92D49,
  defaut_s12_w6_grey737373,
  defaut_s16_w6_black1F1F1F,
  defaut_s12_w6_red_C92D49,
  defaut_s16_w6_white,
  defaut_s14_w6_red_C92D49,
  defaut_s10_w6_orange_FFAA02,
  defaut_s12_w7_grey737373,
  defaut_s12_w4_redC92D49,
  defaut_s14_w6_greyC8C8C8,
  defaut_s14_w7_redC92D49,
  defaut_s20_w7_black1F1F1F,
  defaut_s10_w6_green18A51E,
  defaut_s10_w6_redDE361C,
  defaut_s12_w6_redDE361C
}

extension TextStyleExtention on TextStyleApp {
  TextStyle get style {
    final interBoldFamily = FontApp.interBold.font;
    final interThinFamily = FontApp.interThin.font;
    final interSemiBold = FontApp.interSemiBold.font;
    final interRegular = FontApp.interRegular.font;

    switch (this) {
      case TextStyleApp.defaut_s8_w8_white:
        return _textStyle(
            size: AppDimens.size8,
            weight: FontWeight.w800,
            color: AppColor.white);
      case TextStyleApp.defaut_s9_w5_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size9,
            weight: FontWeight.w500);
      case TextStyleApp.defaut_s9_w5_green37BC9A:
        return _textStyle(
            color: AppColor.green_37BC9A,
            size: AppDimens.size9,
            weight: FontWeight.w500);
      case TextStyleApp.defaut_s9_w5_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size9,
            weight: FontWeight.w500);
      case TextStyleApp.defaut_s11_w5_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size11,
            weight: FontWeight.w500);
      case TextStyleApp.defaut_s11_w5_grey737373_through:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size11,
            weight: FontWeight.w500,
            decoration: TextDecoration.lineThrough);
      case TextStyleApp.defaut_s12_normal_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size12,
            weight: FontWeight.normal);
      case TextStyleApp.defaut_s14_w6_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s14_w6_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s14_w8_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s14_normal_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size14,
            weight: FontWeight.normal);
      case TextStyleApp.defaut_s14_w4_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s14_w8_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size14,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s14_w8_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s18_w8_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size18,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s16_w7_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s16_w7_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size16,
            weight: FontWeight.w700);
      case TextStyleApp.inter_s24_bold_black1F1F1F:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size24);
      case TextStyleApp.inter_s16_w6Thin_black1F1F1F:
        return _textStyle(
            family: interThinFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s14_w4_red_861D2F:
        return _textStyle(
            color: AppColor.red_861D2F,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s10_w4_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s16_w8_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size16,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s16_w4_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size16,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s11_w4_red_861D2F:
        return _textStyle(
            color: AppColor.red_861D2F,
            size: AppDimens.size11,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s11_w4_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size11,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s10_bold_black:
        return _textStyle(
            color: AppColor.black,
            size: AppDimens.size10,
            weight: FontWeight.bold);
      case TextStyleApp.defaut_s13_bold_black:
        return _textStyle(
            color: AppColor.black,
            size: AppDimens.size13,
            weight: FontWeight.bold);
      case TextStyleApp.defaut_s11_w4_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size11,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s14_w4_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s15_w8_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size15,
            weight: FontWeight.w800);
      case TextStyleApp.defaut_s10_w7_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size10,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s15_w7_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size15,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s15_w4_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size15,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s18_w8_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size18,
            weight: FontWeight.w800);
      case TextStyleApp.inter_s14_w4_black1F1F1F:
        return _textStyle(
            family: interThinFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s16_w6_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s12_w4_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s12_w4_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s12_w4_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s10_w6_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size10,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s12_w6_white:
        return _textStyle(
            color: AppColor.white,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s10_w4_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s10_w4_grey737373:
        return _textStyle(
          color: AppColor.grey_737373,
          size: AppDimens.size10,
          weight: FontWeight.w400,
        );
      case TextStyleApp.defaut_s10_w4_grey737373_line:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size10,
            weight: FontWeight.w400,
            decoration: TextDecoration.lineThrough);
      case TextStyleApp.defaut_s14_w6_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s14_w6_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s10_w4_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s14_w5_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size14,
            weight: FontWeight.w500);
      case TextStyleApp.interSemiBold_s18_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size18,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s18_w6_white:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.white,
            size: AppDimens.size18,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s16_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s14_w6_grey575757:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.grey_575757,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s14_w6_greyC8C8C8:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.grey_C8C8C8,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s14_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s14_w6_green37BC9A:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.green_37BC9A,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interRegular_s11_w4_grey575757:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_575757,
            size: AppDimens.size11,
            weight: FontWeight.w400);
      case TextStyleApp.interSemiBold_s18_w6_grey575757:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.grey_575757,
            size: AppDimens.size18,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s16_w6_grey575757:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.grey_575757,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.interRegular_s10_w4_grey575757:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_575757,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s10_w4_green37BC9A:
        return _textStyle(
            family: interRegular,
            color: AppColor.green_37BC9A,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s10_w4_redC92D49:
        return _textStyle(
            family: interRegular,
            color: AppColor.red_C92D49,
            size: AppDimens.size10,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s14_w4_grey575757:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_575757,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s12_w4_grey575757:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_575757,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s12_w4_white:
        return _textStyle(
            family: interRegular,
            color: AppColor.white,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s12_w4_black1F1F1F:
        return _textStyle(
            family: interRegular,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s12_w4_redC92D49:
        return _textStyle(
            family: interRegular,
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s16_w4_black1F1F1F:
        return _textStyle(
            family: interRegular,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s14_w4_black1F1F1F:
        return _textStyle(
            family: interRegular,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w400);
      case TextStyleApp.interRegular_s16_w4_grey737373:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_737373,
            size: AppDimens.size16,
            weight: FontWeight.w400);
      case TextStyleApp.interBold_s16_w7_redC92D49:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.red_C92D49,
            size: AppDimens.size16,
            weight: FontWeight.w700);
      case TextStyleApp.interBold_s14_w7_redC92D49:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w700);
      case TextStyleApp.interBold_s24_black1F1F1F:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size24);
      case TextStyleApp.interBold_s18_w7_black1F1F1F:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size18,
            weight: FontWeight.w700);
      case TextStyleApp.interSemiBold_s16_w6_redC92D49:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.red_C92D49,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.interBold_s14_w7_black1F1F1F:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size14,
            weight: FontWeight.w700);
      case TextStyleApp.interBold_s16_w7_black1F1F1F:
        return _textStyle(
            family: interBoldFamily,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w700);
      case TextStyleApp.interSemiBold_s14_w6_redC92D49:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s14_w6_white:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.white,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s12_w6_redC92D49:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s10_w6_redC92D49:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.red_C92D49,
            size: AppDimens.size10,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s11_w6_redC92D49:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.red_C92D49,
            size: AppDimens.size11,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s12_w6_grey737373:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.grey_737373,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s12_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s10_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size10,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s11_w6_black1F1F1F:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.black_1F1F1F,
            size: AppDimens.size11,
            weight: FontWeight.w600);
      case TextStyleApp.interSemiBold_s12_w6_white:
        return _textStyle(
            family: interSemiBold,
            color: AppColor.white,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.interRegular_s16_w4_greyCACDD1:
        return _textStyle(
            family: interRegular,
            color: AppColor.grey_CACDD1,
            size: AppDimens.size16,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s12_w6_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s12_w4_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s12_w6_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s16_w6_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size16,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s12_w6_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s16_w6_white:
        return _textStyle(
            size: AppDimens.size16,
            weight: FontWeight.w600,
            color: AppColor.white);
      case TextStyleApp.defaut_s17_w3_black1F1F1F:
        return _textStyle(
            size: AppDimens.size17,
            weight: FontWeight.w300,
            color: AppColor.black_1F1F1F);
      case TextStyleApp.defaut_s18_w6_black1F1F1F:
        return _textStyle(
            size: AppDimens.size18,
            weight: FontWeight.w600,
            color: AppColor.black_1F1F1F);
      case TextStyleApp.defaut_s14_w6_red_C92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s10_w6_orange_FFAA02:
        return _textStyle(
            size: AppDimens.size10,
            weight: FontWeight.w600,
            color: AppColor.orange_FFAA02);
      case TextStyleApp.defaut_s12_w7_grey737373:
        return _textStyle(
            color: AppColor.grey_737373,
            size: AppDimens.size12,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s12_w4_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w400);
      case TextStyleApp.defaut_s14_w6_greyC8C8C8:
        return _textStyle(
            color: AppColor.grey_C8C8C8,
            size: AppDimens.size14,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s14_w7_redC92D49:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size14,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s20_w7_black1F1F1F:
        return _textStyle(
            color: AppColor.black_1F1F1F,
            size: AppDimens.size20,
            weight: FontWeight.w700);
      case TextStyleApp.defaut_s10_w6_green18A51E:
        return _textStyle(
            color: AppColor.green_18A51E,
            size: AppDimens.size10,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s10_w6_redDE361C:
        return _textStyle(
            color: AppColor.red_DE361C,
            size: AppDimens.size10,
            weight: FontWeight.w600);
      case TextStyleApp.defaut_s12_w6_redDE361C:
        return _textStyle(
            color: AppColor.red_C92D49,
            size: AppDimens.size12,
            weight: FontWeight.w600);
    }
  }

  TextStyle _textStyle(
      {required Color color,
      String? family,
      required double size,
      FontWeight? weight,
      TextDecoration? decoration}) {
    return TextStyle(
        color: color,
        fontFamily: family,
        fontSize: size,
        fontWeight: weight,
        decoration: decoration);
  }
}
