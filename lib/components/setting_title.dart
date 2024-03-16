import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white,
      ),
      textAlign: TextAlign.start,
    );
  }
}
