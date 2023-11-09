import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemLibroFisicoSeccion extends StatelessWidget {
  const ItemLibroFisicoSeccion({Key? key});

  @override
  Widget build(BuildContext context) {
       final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: themeProvider.isDiurno ? Colors.black12: themeColors[7],
                //color: Colors.black12
                ),
              borderRadius: BorderRadius.circular(10)
              
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                   width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    
                     borderRadius: BorderRadius.circular(10)
                 
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/detalle");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/lib2.jfif",
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre la imagen y el texto
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título del libro o descripción',
                          style: TextStyle(fontWeight: FontWeight.bold,color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],),
                        ),
                        Text(
                          'Autor o información adicional',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
