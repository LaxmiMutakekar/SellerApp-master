import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius radius;
  final Color color;
  final Widget child;

  const Cards(
      {Key key, this.margin, this.padding, this.radius, this.color, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      clipBehavior: Clip.hardEdge,
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
        borderRadius: radius ?? BorderRadius.circular(5),
      ),
      child: Material(
        child: child,
        color: Colors.transparent,
        borderRadius: radius ?? BorderRadius.circular(5),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}

// class ContainerCard extends StatelessWidget {
//   final EdgeInsets margin;
//   final EdgeInsets padding;
//   final BorderRadius radius;
//   final Color color;
//   final Widget child;
//   final double height;
//   final double width;
//   const ContainerCard(
//       {Key key,
//       this.margin,
//       this.padding,
//       this.radius,
//       this.color,
//       this.child,
//       this.height,
//       this.width})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//         constraints: BoxConstraints(
//             minHeight: height ?? MediaQuery.of(context).size.height),
//         child: Container(
//             decoration: BoxDecoration(
//               color: color ?? Theme.of(context).canvasColor,
//               borderRadius: BorderRadius.only(
//                   topLeft: radius ?? Radius.circular(30),
//                   topRight: radius ?? Radius.circular(30)),
//             ),
//             padding: padding ?? EdgeInsets.all(16),
//             child: Material(
//               child: child,
//               color: Colors.transparent,
//               borderRadius: radius ?? BorderRadius.circular(5),
//               clipBehavior: Clip.hardEdge,
//             )));
//   }
// }
