import 'package:flutter/material.dart';
import '../helper/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final void Function() onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 45,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: blueBright3,
        fixedSize: Size(width, height),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(title),
    );
  }
}
