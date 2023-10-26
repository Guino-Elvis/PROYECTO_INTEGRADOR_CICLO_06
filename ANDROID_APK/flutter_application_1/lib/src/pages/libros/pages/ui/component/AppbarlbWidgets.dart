// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/pages/libros/pages/ui/Favoritos.dart';

// class AppbarlbWidgets extends StatelessWidget {
//   const AppbarlbWidgets({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(25),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () {
//               Scaffold.of(context).openDrawer(); // Abre el Drawer al tocar el icono de hamburguesa
//             },
//             child: Icon(
//               Icons.menu,
//               color: Color(0xFF4C53A5),
//               size: 30,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: Text(
//               "Biblioteca",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF4C53A5),
//               ),
//             ),
//           ),
//           Spacer(),
//           InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, "/favoritos");
//             },
//             child: Icon(
//               Icons.favorite_outline,
//               size: 25,
//               color: Color(0xFF4C53A5),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
