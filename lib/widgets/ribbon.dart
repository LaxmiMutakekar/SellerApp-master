import 'package:flutter/material.dart';
class RibbonShape extends StatelessWidget {
  final Color color;
  final Widget child;

  const RibbonShape({Key key, this.color, this.child}) : super(key: key);
  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: ClipPath(
            clipper: ArcClipper(),
            child: Container(
                width: 150.0,
                height: 30.0,
                padding: EdgeInsets.all(5.0),
                color:color?? Colors.lightBlue,
                child: child),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: ClipPath(
            clipper: TriangleClipper(),
            child: Container(
              width: 5.0,
              height: 10.0,
              color: color??Colors.blue[700],
            ),
          ),
        )
      ],
    );
  }
}
 
class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    //path.lineTo(15.0, 0.0);
 
    // var firstControlPoint = Offset(7.5, 2.0);
    // var firstPoint = Offset(5.0, 5.0);
    // path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
    //     firstPoint.dx, firstPoint.dy);
 
    // var secondControlPoint = Offset(2.0, 7.5);
    // var secondPoint = Offset(0.0, 15.0);
    // path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
    //     secondPoint.dx, secondPoint.dy);
 
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - 20, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.close();
 
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
 
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
 
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}