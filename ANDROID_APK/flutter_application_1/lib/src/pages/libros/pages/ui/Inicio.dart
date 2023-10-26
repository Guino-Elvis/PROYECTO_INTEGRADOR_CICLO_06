// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/component/ButtombarWidgets.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/component/DrawerWidgets.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/categoria/CategoriesWidgets.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/component/AppbarlbWidgets.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets0.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets1.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets2.dart';

class Inicio extends StatelessWidget {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // const Inicio({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
           onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
            child: Icon(
              Icons.sort,
              color: Color(0xFF4C53A5),
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
                color: Color(0xFF4C53A5),
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
              color: Color(0xFF4C53A5),
            ),
          ),
        ],
      ),
    ),
          Container(
            // height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Busca lo que quieras...",
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        color: Color(0xFF4C53A5),
                        size: 27,
                      )
                    ],
                  ),
                ),
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
                      color: Color(0xFF4C53A5),
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
                      color: Color(0xFF4C53A5),
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
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                ItemWidgets2(),
             
              ],
            ),
          ),
        ],
      ),
      drawer: DrawerWidgets(),
      // bottomNavigationBar: ButtombarWidgets(),
    );
  }
}
