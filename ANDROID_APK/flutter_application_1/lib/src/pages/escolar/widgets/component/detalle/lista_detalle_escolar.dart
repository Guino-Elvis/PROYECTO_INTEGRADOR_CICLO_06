import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/asistencia.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/video.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ListViewEscolarDetalle extends StatefulWidget {
  const ListViewEscolarDetalle({super.key});

  @override
  State<ListViewEscolarDetalle> createState() => _ListViewEscolarDetalleState();
}

class _ListViewEscolarDetalleState extends State<ListViewEscolarDetalle> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio:
            3 / 1, // Relación de aspecto entre la imagen y el texto
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetalleEscolar()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(0), // Sin relleno para eliminar márgenes
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ]),
            child: Row(
              children: [
                // Parte izquierda para la imagen
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/curso2.jpg",
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: HexColor("#0e1b4d").withOpacity(0.7),
                        ),
                        Center(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '26',
                                  style: TextStyle(
                                    color: Colors.white, // Color del texto
                                    fontSize: 28, // Tamaño de la fuente
                                    fontWeight:
                                        FontWeight.bold, // Peso de la fuente
                                  ),
                                ),
                                Text(
                                  'Oct',
                                  style: TextStyle(
                                    color: Colors.white, // Color del texto
                                    fontSize: 22, // Tamaño de la fuente
                                    fontWeight:
                                        FontWeight.bold, // Peso de la fuente
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Parte derecha para el texto
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // Espacio entre la imagen y el texto
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1.2-\n Instrumento: Rúbrica de prueba de desarrollo, evaluación formativa.',
                          style: TextStyle(
                            color: HexColor("#080C1E").withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),

                        Divider(
                          color: HexColor("#080C1E").withOpacity(0.8),
                        ),
                        Container(
                          child: Center(
                            child: Container(
                              child: Row(
                                // Alinea los elementos a la derecha
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.white,
                                          border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.circular(
                                              90), // Ajusta el radio según lo necesites
                                        ),
                                        padding: EdgeInsets.all(0.1),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoEscolar()),
                                            );
                                          },
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '35',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      Text(
                                        '35',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AsistenciaEscolar()),
                                          );
                                        },
                                        child: Icon(
                                          Icons.checklist,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                      Text(
                                        'Asistencia',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Otros widgets de texto o contenido para esta mitad
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
