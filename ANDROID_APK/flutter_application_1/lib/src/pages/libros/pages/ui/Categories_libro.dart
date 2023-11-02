import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/search_component.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/opciones_seccion3.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/home_screen_escolar.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/categoria/Item_categoria_seccion.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets0.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class CategoriView extends StatelessWidget {
  const CategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 565,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/lib2.jfif'),
                fit: BoxFit.cover,
              ),
            ),
            
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: HexColor("#0e1b4d").withOpacity(0.8),
                  ),
                ),
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
                                    builder: (context) => Inicio()),
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
                              Icons.favorite_outline,
                              size: 25,
                              color: HexColor('#F82249'),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Container(
                      padding: EdgeInsets.only(left: 25),
                      alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(
                              'Categoria: Terror',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                     ),
                     SizedBox(height: 20,),
                     Container(
                      padding: EdgeInsets.only(left: 25),
                      alignment: Alignment.centerLeft,
                      width: 170,
                        child: Column(
                          children: [
                           Text(
                              'Total de libros',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                 ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          SearchItem(),
                          SizedBox(height: 15),
                          ItemWidgets0(),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(230, 70),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2,
                          0.004) // Establecer un valor para la perspectiva
                      ..rotateY(0.3), // Girar en el eje Y
                    alignment: FractionalOffset.center,
                    child: Container(
                      width: 130,
                      height: 180,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/lib2.jfif",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: ItemCategoriaSeccion(),
          ),
        ],
      ),
    );
  }
}
