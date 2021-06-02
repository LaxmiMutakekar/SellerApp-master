import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CustomClipPath extends CustomClipper<Path> {
  var radius = 30.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.moveTo(size.width / 12, 0);
    var firstEnd = new Offset(0, size.height / 3);
    var firstControl = new Offset(0, 0);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    //path.lineTo(0, size.height/3);
    var secondEnd = new Offset(radius, size.height * 0.7);
    var secondControl = new Offset(0, size.height * 0.7);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width * 0.7 - 10, size.height * 0.7);
    var thirdEnd = new Offset(size.width * 0.7 + radius, size.height);
    var thirdControl = new Offset(size.width * 0.7, size.height);
    path.quadraticBezierTo(
        thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width - radius, size.height);
    var forthEnd = new Offset(size.width, size.height - radius);
    var forthControl = new Offset(size.width, size.height);
    path.quadraticBezierTo(
        forthControl.dx, forthControl.dy, forthEnd.dx, forthEnd.dy);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height / 4 + 10);
    var fifthEnd = new Offset(size.width - radius, 0);
    var fifthControl = new Offset(size.width, 0);
    path.quadraticBezierTo(
        fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BorderPainter extends CustomPainter {
  var radius = 30.0;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.black;
    Path path = Path();
    path.moveTo(size.width / 12, 0);
    var firstEnd = new Offset(0, size.height / 3);
    var firstControl = new Offset(0, 0);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    var secondEnd = new Offset(radius, size.height * 0.7);
    var secondControl = new Offset(0, size.height * 0.7);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width * 0.7 - 10, size.height * 0.7);
    var thirdEnd = new Offset(size.width * 0.7 + radius, size.height);
    var thirdControl = new Offset(size.width * 0.7, size.height);
    path.quadraticBezierTo(
        thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width - radius, size.height);
    var forthEnd = new Offset(size.width, size.height - radius);
    var forthControl = new Offset(size.width, size.height);
    path.quadraticBezierTo(
        forthControl.dx, forthControl.dy, forthEnd.dx, forthEnd.dy);
    path.lineTo(size.width, size.height / 4 + 10);
    var fifthEnd = new Offset(size.width - radius, 0);
    var fifthControl = new Offset(size.width, 0);
    path.quadraticBezierTo(
        fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
