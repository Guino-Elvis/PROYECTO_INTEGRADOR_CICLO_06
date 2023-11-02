// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/component/user/drawer/drawers.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/categoria/CategoriesWidgets.dart';

import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets0.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets1.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets2.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Inicio extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          if (!themeProvider.isDiurno) // Condición para mostrar la imagen y el color encima
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondonegro1.jfif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
         if (!themeProvider.isDiurno) // Condición para mostrar el color encima de la imagen
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Color encima de la imagen
              ),
            ),
          ListView(
            children: [
              Container(
                color: themeProvider.isDiurno ? Colors.white: themeColors[8],
                padding: EdgeInsets.all(25),
                child: Row(
                  children: [
                  InkWell(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Icon(
                    Icons.sort,
                    color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                   // color: HexColor("#0e1b4d"),
                    size: 30,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Biblioteca",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/favoritos");
                  },
                  child: Icon(
                    Icons.favorite_outline,
                    size: 25,
                    color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                  ),
                ),
                  ],
                ),
              ),
              Container(
                
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: themeProvider.isDiurno ? Colors.white: themeColors[8],
               
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                     Container(
                 
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 14,),
                  height: 50,
                  decoration: BoxDecoration(
                    
                     color: themeProvider.isDiurno ? Colors.white: themeColors[9],
                    //color: Colors.white,
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          style: TextStyle(color: themeProvider.isDiurno ? Colors.black : Colors.white,),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Busca lo que quieras...",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                        size: 27,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                ItemWidgets0(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Categorias",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                    ),
                  ),
                ),
                Categoriesview(),
                //seccion2 categoria
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Best Stilling",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                    ),
                  ),
                ),
                ItemWidgets1(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Best Stilling",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                    ),
                  ),
                ),
                ItemWidgets2(),
              ],
               
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}




