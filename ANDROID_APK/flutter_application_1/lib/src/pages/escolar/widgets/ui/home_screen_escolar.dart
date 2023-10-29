import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/user/drawer/drawers.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/grafico_torta_escolar.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/opciones_seccion2.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/opciones_seccion3.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class HomeScreenEscolar extends StatelessWidget {
  // const HomeScreenEscolar({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 400,
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
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Icon(
                              Icons.sort,
                              color: HexColor('#F82249'),
                              size: 30,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Colegio",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#F82249'),
                              ),
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
                      child: Container(
                          height: 200, // Define un alto fijo para el gráfico
                          width: 480,
                          padding: EdgeInsets.all(13),
                          child: GraficoTorta()),
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
          Seccion2Escolar(),
          Seccion3Escolar(),
        ],
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
