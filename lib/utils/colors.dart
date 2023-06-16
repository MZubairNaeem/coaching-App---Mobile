
import 'package:flutter/material.dart';

class AppColors{
  var primaryColor = const Color(0xff0f52ba);
  var whiteColor = const Color(0xffffffff);
  var darKShadowColor = const Color(0xff6f6f6f);
  var lightShadowColor = const Color(0xffd7d7d7);
  var blackColor = const Color(0xff000000);
  var accentColor = const Color(0xffc73866);
  var receiverColor = const Color(0x000000ff);
  var senderColor = const Color(0xffe6e9f5);
  var redColor =  Colors.red;
}

const primaryColor = Color(0xff0f52ba);
const whiteColor = Color(0xffffffff);
const darKShadowColor = Color(0xff6f6f6f);
const lightShadowColor = Color(0xffd7d7d7);
const blackColor = Color(0xff000000);
const accentColor = Color(0xffc73866);


final myTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: whiteColor,
  shadowColor: darKShadowColor,
  highlightColor: Colors.transparent,
  dialogBackgroundColor: whiteColor,
  cardColor: whiteColor,
  disabledColor: lightShadowColor,
  dividerColor: lightShadowColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: whiteColor,
    iconTheme: IconThemeData(color: blackColor),
    titleTextStyle:TextStyle(
        color: blackColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
    ),
  ), colorScheme: const ColorScheme.light(primary: primaryColor, secondary: accentColor).copyWith(secondary: accentColor).copyWith(background: whiteColor).copyWith(error: accentColor),
);
