import 'package:flutter/material.dart';
// class ZigZagClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height);
//     path.lineTo(size.width * 0.1, size.height);
//     for (var i = 0; i < 5; i++) {
//       path.lineTo(size.width * (0.1 + 0.1 * i), size.height - 15);
//       path.lineTo(size.width * (0.2 + 0.1 * i), size.height);
//     }
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

