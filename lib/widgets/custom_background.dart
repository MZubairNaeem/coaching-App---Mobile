import 'package:flutter/cupertino.dart';

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); //Start point p1
    var firstControlPoint =
        Offset(size.width * 0.02, size.height - 70); // mid point p2
    var firstEndPoint =
        Offset(size.width * 0.2, size.height - 70); // end point p3
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy); //quadratic bezier curve p1 to p3
    //Straight line p3 to p4
    var secondControlPoint =
        Offset(size.width * 0.8, size.height - 70); // mid point p4
    var secondEndPoint =
        Offset(size.width * 0.8, size.height - 70); // end point p5
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint =
        Offset(size.width * 0.98, size.height - 70); //p6 mid point
    var thirdEndPoint = Offset(size.width, size.height - 140); //p7 end point
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
