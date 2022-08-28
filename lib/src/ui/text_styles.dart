import 'package:distributor/conf/style/lib/colors.dart';
import 'package:distributor/conf/style/lib/fonts.dart';
import 'package:distributor/conf/style/lib/text_styles.dart';
import 'package:distributor/ui/shared/brand_colors.dart';
import 'package:flutter/material.dart';

TextStyle kMainTextStyle = TextStyle();
TextStyle kCommentTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black45);

TextStyle kListStyleTitle1 = TextStyle(
    color: kColorMiniDarkBlue, fontSize: 16, fontWeight: FontWeight.w600);
TextStyle kListStyleTitle2 =
    TextStyle(color: Colors.black12, fontSize: 16, fontWeight: FontWeight.w400);
TextStyle kListStyleSubTitle1 =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: kLightBlue);
TextStyle kListStyleSubTitle2 = TextStyle(
  fontSize: 12,
);
const kActiveButtonTextStyle =
    TextStyle(fontFamily: 'ProximaNova500', color: Color(0xFFfff200));
TextStyle kListStyleItemCount = TextStyle(
  fontSize: 16,
);

const TextStyle kCartQuantity =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

const TextStyle kCartSecondaryStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

const TextStyle kTabTextStyleActive = TextStyle(
    fontFamily: kFontBoldHeading,
    color: kColorDDSPrimaryDark,
    fontSize: kLabelTextSize);
