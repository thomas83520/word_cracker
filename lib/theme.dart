import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
  useMaterial3: true,
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.red),
      textStyle: MaterialStatePropertyAll(
        TextStyle(color: Colors.white),
      ),
    ),
  ),
);
