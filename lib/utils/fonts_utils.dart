import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:submiss1_fundamental/utils/color.dart';
import 'package:submiss1_fundamental/utils/size.dart';

class AppFontWeight {
  static const FontWeight light = FontWeight.w300;

  static const FontWeight regular = FontWeight.w400;

  static const FontWeight medium = FontWeight.w500;

  static const FontWeight semiBold = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;

  static const FontWeight extraBold = FontWeight.w800;

  static const FontWeight black = FontWeight.w900;
}

class AppTextStyle {
  /// FontWeight.w300

  static final TextStyle light = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.light,
    color: TextFieldColors.text,
  );

  /// FontWeight.w400
  static final TextStyle regular = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.regular,
    color: TextFieldColors.text,
  );

  /// FontWeight.w500
  static final TextStyle medium = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.medium,
    color: TextFieldColors.text,
  );

  /// FontWeight.w600
  static final TextStyle semiBold = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.semiBold,
    color: TextFieldColors.text,
  );

  /// FontWeight.w700
  static final TextStyle bold = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.bold,
    color: TextFieldColors.text,
  );

  /// FontWeight.w800
  static final TextStyle extraBold = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.extraBold,
    color: TextFieldColors.text,
  );

  /// FontWeight.w900
  static final TextStyle black = GoogleFonts.alatsi(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.black,
    color: TextFieldColors.text,
  );
}
