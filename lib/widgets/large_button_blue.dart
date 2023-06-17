import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LargeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;
  final EdgeInsetsGeometry? margin;

  const LargeButton({Key? key, this.onPressed, required this.name, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        width: double.infinity,
        height: screenHeight * 0.075,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors().primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
