import 'package:flutter/material.dart';

const defaultPadding = 8.0;
const smallPadding = 4.0;
const largePadding = 16.0;

const Color white = Color(0xFFFFFFFF);
const Color darkGrey = Color(0xFF4F4F4F);
const Color gradientColorPink = Color(0xFFF36D9E);
const Color activeMenuTop = Color(0xFF8511E0);
const Color gradientColorBlue = Color(0xFF2E21AC);
const Color gradientColorsPurple = Color(0xFFCD8CFF);
const Color gradientColorsOrange = Color(0xFFFFB7B7);
const Color gradientColorsYellow = Color(0xFFFFE790);

final Paint paintGradientBluePinkPurple = Paint()
  ..shader = linearGradientPinkLightPinkPurple
      .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

const LinearGradient linearGradientPinkLightPinkPurple = LinearGradient(
  colors: <Color>[gradientColorPink, activeMenuTop, gradientColorBlue],
  end: Alignment.topRight,
  begin: Alignment.bottomLeft,
);

final LinearGradient bgGradientPurpleOrangeYellow = LinearGradient(colors: [
  white,
  white,
  gradientColorsPurple.withAlpha(8),
  gradientColorsOrange.withAlpha(100),
  gradientColorsYellow.withAlpha(100),
], begin: Alignment.topCenter, end: Alignment.bottomCenter);

const textStyle16w500DarkGrey = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: darkGrey,
);

final textStyle36w400Gradient = TextStyle(
    foreground: paintGradientBluePinkPurple,
    fontSize: 36,
    fontWeight: FontWeight.w400);
