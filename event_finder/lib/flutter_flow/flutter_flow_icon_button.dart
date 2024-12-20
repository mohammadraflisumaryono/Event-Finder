import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final double size;

  const FlutterFlowIconButton({
    required this.icon,
    required this.onPressed,
    this.color = Colors.blue,
    this.size = 24.0,
    super.key, required Color borderColor, required int borderRadius, required int buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      onPressed: onPressed,
    );
  }
}
