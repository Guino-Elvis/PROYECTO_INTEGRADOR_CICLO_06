import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Seccion2Escolar extends StatelessWidget {
  const Seccion2Escolar({Key? key}) : super(key: key);

  Widget buildItem(BuildContext context, String link, IconData icon, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, link);
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
