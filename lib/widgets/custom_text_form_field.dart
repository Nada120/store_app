import 'package:flutter/material.dart';
import '../helper/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final Color iconColor;
  final Color backColor;
  final bool isObscure;
  final double borderRadius;
  final TextEditingController? controller;
  final AutovalidateMode validateMode;
  final double paddingWidth;
  final String? Function(String?)? validate;
  final double elevation;
  final bool unenable;
  final void Function(String)? onChange;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validateMode,
    required this.validate,
    this.isObscure = false,
    this.borderRadius = 5,
    this.iconColor = blueDark2,
    this.backColor = blueBright1,
    this.paddingWidth = 50,
    this.elevation = 0,
    this.unenable = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingWidth),
      child: TextFormField(
        onChanged: onChange,
        readOnly: false,
        cursorColor: blueDark2,
        obscureText: isObscure,
        controller: controller,
        autovalidateMode: validateMode,
        validator: validate,
        style: const TextStyle(
          color: blueDark2,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: backColor,
          hoverColor: backColor,
          suffixIcon: icon,
          suffixIconColor: iconColor,
          hintText: hintText,
          hintStyle: const TextStyle(color: blueDark2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
          errorBorder: customBorder(red, borderRadius),
          focusedBorder: customBorder(blueBright3, borderRadius),
        ),
      ),
    );
  }
}

OutlineInputBorder customBorder(Color color, double radius) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(color: color),
  );
}
