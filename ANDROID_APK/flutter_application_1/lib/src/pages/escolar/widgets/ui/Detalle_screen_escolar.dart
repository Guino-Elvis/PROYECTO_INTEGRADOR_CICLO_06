import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/appe_bar_option.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/barra_progreso.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/opciones_seccion3.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/home_screen_escolar.dart';

import 'package:snippet_coder_utils/hex_color.dart';

class DetalleEscolar extends StatelessWidget {
  final String nombreCurso;
  final String cursoId;
  final String nombreDocente;

  const DetalleEscolar({
    super.key,
    required this.nombreCurso,
    required this.nombreDocente,
    required this.cursoId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: HexColor("#0e1b4d"),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(23),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreenEscolar()),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: HexColor('#F82249'),
                              size: 30,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "");
                            },
                            child: Icon(
                              Icons.notifications_none,
                              size: 25,
                              color: HexColor('#F82249'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        '$cursoId $nombreCurso Ciclo: 4 - unico',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 300,
                        child: Text(
                          'EP Ingeniería de Sistemas - Docente: $nombreDocente',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(left: 20, right: 50),
                              child: BarraProgreso()),
                        ),
                        OptionBarEscuela(),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(40)),
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      height: 90,
                      color: Colors.white,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(5, 5),
                              )
                            ],
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Busca todo lo que quieras",
                                helperStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.red,
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Seccion3EscolarDetalle(
              nombreCurso: nombreCurso, // Puedes pasar los mismos datos o datos diferentes
              nombreDocente: nombreDocente,
              cursoId: cursoId,
            ),
          ),
        ],
      ),
    );
  }
}
