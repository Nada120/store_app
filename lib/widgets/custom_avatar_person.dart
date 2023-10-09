import 'package:flutter/material.dart';
import '../helper/colors.dart';

class CustomAvaterPerson extends StatelessWidget {
  final double circleSize;
  final double iconSize;
  final double verticalPadding;

  const CustomAvaterPerson({
    super.key,
    this.circleSize = 150,
    this.iconSize = 100,
    this.verticalPadding = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      margin: EdgeInsets.symmetric(vertical: verticalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        gradient: const LinearGradient(
          colors: [
            blueBright2,
            blueBright3,
            blueBright3,
            blueBright2,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: grey,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.person,
        color: blueDark2,
        size: iconSize,
      ),
    );
  }
}
