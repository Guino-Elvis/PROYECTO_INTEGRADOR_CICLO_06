// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/asistencia.dart';
// import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/video.dart';
// import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// class GridViewEscolarDetalle extends StatefulWidget {
//   const GridViewEscolarDetalle({super.key});

//   @override
//   State<GridViewEscolarDetalle> createState() => _GridViewEscolarDetalleState();
// }

// class _GridViewEscolarDetalleState extends State<GridViewEscolarDetalle> {
//   bool isLongPress = false;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: 6,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 5 / 4.5,
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//       ),
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           onLongPress: () {
//             setState(() {
//               isLongPress = !isLongPress;
//             });
//           },
         
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(5), topRight: Radius.circular(5)),
//                 color: Colors.white,
//                 // border: Border.all(color: Colors.white),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 2,
//                     offset: Offset(0, 2),
//                   )
//                 ]),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(5),
//                       topRight: Radius.circular(5)),
//                   child: Image.asset(
//                     "assets/curso3.jpg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         color: HexColor("#080C1E").withOpacity(0.9),
//                         padding: EdgeInsets.all(0),
//                         child: Column(
//                           children: [
//                             Text(
//                               '1.2 Instrumento: Rúbrica de prueba de desarrollo, evaluación formativa.',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             Text(
//                               '26 Set',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (isLongPress)
//                         Container(
//                           color: HexColor("#080C1E").withOpacity(0.8),
//                           padding: EdgeInsets.all(0),
//                           width:
//                               double.infinity, // Ocupa todo el ancho disponible
//                           child: Container(
//                             child: Center(
//                               child: Container(
//                                 padding: EdgeInsets.only(right: 4),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   // Alinea los elementos a la derecha
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                             // color: Colors.white,
//                                             border:
//                                                 Border.all(color: Colors.white),
//                                             borderRadius: BorderRadius.circular(
//                                                 90), // Ajusta el radio según lo necesites
//                                           ),
//                                           padding: EdgeInsets.all(0.1),
//                                           child: InkWell(
//                                              onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       VideoEscolar()),
//                                             );
//                                           },
//                                             child: Icon(
//                                               Icons.play_arrow_rounded,
//                                               color: Colors.white,
//                                               size: 15,
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           '35',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(width: 10),
//                                     Column(
//                                       children: [
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                         Text(
//                                           '35',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(width: 10),
//                                     Column(
//                                       children: [
//                                         InkWell(
//                                            onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       AsistenciaEscolar(nombreCurso: '', nombreDocente: '', cursoId:'',)),
//                                             );
//                                           },
//                                           child: Icon(
//                                             Icons.checklist,
//                                             color: Colors.white,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Text(
//                                           'Asistencia',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 10),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
