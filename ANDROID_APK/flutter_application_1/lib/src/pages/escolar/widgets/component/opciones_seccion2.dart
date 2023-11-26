import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/asistencia.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Seccion2Escolar extends StatefulWidget {
  
  const Seccion2Escolar({Key? key}) : super(key: key);

  @override
  State<Seccion2Escolar> createState() => _Seccion2EscolarState();
}

class _Seccion2EscolarState extends State<Seccion2Escolar> {
  Widget buildItem(BuildContext context, dynamic link, IconData icon, String text, {bool isRoute = true}) {
    return GestureDetector(
       onTap: () {
        if (isRoute) {
          Navigator.pushNamed(context, link);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => link));
        }
      },
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Icon(
              icon,
              color: Colors.red,
            ),
          ),
          Text(
            text, // Aquí se muestra el texto correspondiente
            style: TextStyle(
              color: HexColor("#0e1b4d"),
              fontSize: 15,
              fontWeight: FontWeight.bold,
              wordSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Container(
            child: Wrap(
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 20,
              children: [
                buildItem(context, "/alumno", Icons.ac_unit, "Categoria"),
                buildItem(context, "/librohome", Icons.access_alarm, "Biblioteca"),
                buildItem(context, "link_para_columna_3", Icons.access_time, "Otros"),
                buildItem(context, "link_para_columna_4", Icons.account_balance, "otros"),
                buildItem(context, AsistenciaEscolar(nombreCurso: '', nombreDocente: '', cursoId: '',), Icons.checklist, "Asistencias", isRoute: false),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
