import 'package:flutter/material.dart';

import '../utils/colors.dart';

class LargeButtonTransparentLeftAlignText extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;
  final EdgeInsetsGeometry? margin;

  const LargeButtonTransparentLeftAlignText({Key? key, this.onPressed, required this.name, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // margin: EdgeInsets.symmetric(),
        width: double.infinity,
        height: screenHeight * 0.06,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                name,
                style: TextStyle(color: AppColors().darKShadowColor, fontSize: 18,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: Icon(Icons.chevron_right_sharp,color: AppColors().darKShadowColor,)
            ),

          ],
        ),
      ),
    );
  }
}
