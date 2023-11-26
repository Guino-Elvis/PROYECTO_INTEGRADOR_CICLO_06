// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/src/controller/setup/Colegio/Inscripccion_colegio_controller.dart';
// import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
// import 'package:snippet_coder_utils/hex_color.dart';

// class ListViewEscolar extends StatefulWidget {
//   const ListViewEscolar({super.key});

//   @override
//   State<ListViewEscolar> createState() => _ListViewEscolarState();
// }

// class _ListViewEscolarState extends State<ListViewEscolar> {

//    final IncripcionController _incripcionController = IncripcionController();
//   List<List<Map<String, dynamic>>> _inscripcionesDetalles = [];
  
  
//   @override
//   void initState() {
//     super.initState();
//     _cargarDatos();
//   }

//     void _cargarDatos() async {
//       final inscripcionesDetalles = await _incripcionController.getInscripccions();
//     setState(() {
//        _inscripcionesDetalles = inscripcionesDetalles.cast<List<Map<String, dynamic>>>();
//     });
//   }
//   //vista

//   @override
//   Widget build(BuildContext context ) {
//     return GridView.builder(
   
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         childAspectRatio:
//             4 / 1, // Relación de aspecto entre la imagen y el texto
//         mainAxisSpacing: 10,
//         crossAxisSpacing: 10,
//       ),
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//         itemCount: _inscripcionesDetalles.length,
//       itemBuilder: (BuildContext context, int index) {
//          final inscripcion = _inscripcionesDetalles[index];
//         final serie = inscripcion.isNotEmpty ? inscripcion[0]['serie'] : '';
//         final inscripcionId = inscripcion.isNotEmpty ? inscripcion[0]['id'] : '';
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => DetalleEscolar()),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.all(0), // Sin relleno para eliminar márgenes
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     spreadRadius: 1,
//                     blurRadius: 2,
//                     offset: Offset(0, 2),
//                   )
//                 ]),
//             child: Row(
//               children: [
//                 // Parte izquierda para la imagen
//                 Expanded(
//                   flex: 1,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                     ),
//                     child: Stack(
//                       children: [
//                         Image.asset(
//                           "assets/curso2.jpg",
//                           width: 500,
//                           fit: BoxFit.cover,
//                         ),
//                         Container(
//                           color: HexColor("#0e1b4d").withOpacity(0.7),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Parte derecha para el texto
//                 Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10), // Espacio entre la imagen y el texto
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Seguimiento y control de proyectos informáticos',
//                           style: TextStyle(
//                              color: HexColor("#080C1E").withOpacity(0.8),
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.start,
//                         ),
                        
//                         Text(
//                           'Ciclo VI - G1',
//                           style: TextStyle(
//                              color: HexColor("#F82249"),
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.start,
//                         ),
//                         Divider(color: HexColor("#080C1E").withOpacity(0.8),),
//                         Text(
//                           'Nelida Gladys Maquera Sosa',
//                           style: TextStyle(
//                              color: HexColor("#080C1E").withOpacity(0.8),
//                             fontSize: 11,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.start,
//                         ),
//                         // Otros widgets de texto o contenido para esta mitad
//                       ],
//                     ),
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
