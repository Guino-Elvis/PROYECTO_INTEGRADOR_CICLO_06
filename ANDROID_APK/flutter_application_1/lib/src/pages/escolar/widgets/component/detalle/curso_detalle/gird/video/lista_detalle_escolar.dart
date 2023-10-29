import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ListViewEscolarDetalleVideo extends StatefulWidget {
  const ListViewEscolarDetalleVideo({super.key});

  @override
  State<ListViewEscolarDetalleVideo> createState() =>
      _ListViewEscolarDetalleVideoState();
}

class _ListViewEscolarDetalleVideoState
    extends State<ListViewEscolarDetalleVideo> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio:
            4 / 1, // Relación de aspecto entre la imagen y el texto
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            
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
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(
                                        90), // Ajusta el radio según lo necesites
                                  ),
                                  padding: EdgeInsets.all(0.1),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.red,
                                    size: 45,
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
                          '27 de octubre',
                          style: TextStyle(
                            color: HexColor("#080C1E").withOpacity(0.8),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
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
