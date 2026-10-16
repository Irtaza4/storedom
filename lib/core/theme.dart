import 'package:flutter/material.dart';

const ink = Color(0xFF24212C);
const paper = Color(0xFFF7F5F0);
const purple = Color(0xFF7456C8);
const lime = Color(0xFFE5F589);
const muted = Color(0xFF827C89);
const night = Color(0xFF292333);

TextStyle display(
  double size, {
  Color color = ink,
  FontWeight weight = FontWeight.w700,
}) => TextStyle(
  fontFamily: 'SpaceGrotesk',
  fontSize: size,
  height: 1.02,
  letterSpacing: -size * .045,
  fontWeight: weight,
  color: color,
);
TextStyle mono({Color color = muted, double size = 10}) => TextStyle(
  fontFamily: 'DMMono',
  color: color,
  fontSize: size,
  letterSpacing: 1.2,
  height: 1.4,
);
ThemeData get oddlyTheme => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: paper,
  colorScheme: ColorScheme.fromSeed(seedColor: purple, surface: paper),
  fontFamily: 'Manrope',
  textTheme: const TextTheme(bodyMedium: TextStyle(color: ink, height: 1.5)),
  appBarTheme: const AppBarTheme(
    backgroundColor: paper,
    foregroundColor: ink,
    surfaceTintColor: Colors.transparent,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: ink,
      foregroundColor: Colors.white,
      minimumSize: const Size(48, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    ),
  ),
);
