import 'package:flutter/material.dart';

class getvisibilityIcon extends StatelessWidget {

final bool isVisible;
final VoidCallback onPressed;

  const getvisibilityIcon({super.key, required this.isVisible,
    required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}