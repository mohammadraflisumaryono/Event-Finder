// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.blueAccent;

  static TextStyle titleStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle bodyStyle = const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static TextStyle bodyMedium = const TextStyle(
  fontSize: 16,
  color: Colors.grey,
  );

  static TextStyle bodySmall = const TextStyle(
  fontSize: 16,
  color: Colors.grey,
  );

  static var displaySmall;

  static of(BuildContext context) {}
}