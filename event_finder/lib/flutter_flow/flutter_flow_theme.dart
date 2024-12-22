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

  static of(BuildContext context) {}
}