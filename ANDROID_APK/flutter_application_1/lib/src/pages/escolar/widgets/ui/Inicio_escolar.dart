// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/pages/escolar/widgets/ui/home_screen_escolar.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// class InicioEscolar extends StatelessWidget {
//   const InicioEscolar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 1.6,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 1.6,
//                   decoration: BoxDecoration(
//                     color: HexColor("#0e1b4d"),
//                     borderRadius:
//                         BorderRadius.only(bottomRight: Radius.circular(70)),
//                   ),
//                   child: Center(
//                     child: Image.asset(
//                       'assets/lib1.jfif',
//                       scale: 0.8,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 2.666,
//                 decoration: BoxDecoration(
//                   color: HexColor("#0e1b4d"),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 2.666,
//                 padding: EdgeInsets.only(top: 40, bottom: 30),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Learning is Everything",
//                       style: TextStyle(
//                           color: HexColor("#0e1b4d"),
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                           wordSpacing: 2),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         "Velit consequatur consequatur inventore iste fugit unde omnis eum aut.",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 15,
//                           letterSpacing: 1,
//                           wordSpacing: 2,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5),
//                       width: 90.0, // 20 centímetros (200 puntos)
//                       color: HexColor('#F82249'), // Color de la línea
//                       height: 5.0, // Grosor de la línea
//                     ),
//                     SizedBox(height: 60,),
//                     Material(
//                       color: HexColor('#F82249'),
//                       borderRadius: BorderRadius.circular(90),
//                       child: InkWell(
//                         onTap: (){
//                           Navigator.push(context,MaterialPageRoute(
//                             builder: (context) => HomeScreenEscolar(),
//                           ),);
//                         },
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 15,horizontal: 80,
//                           ),
//                           child: Text(
//                             "Get start",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1,
//                             ),
//                           ),
                         
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
