import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemWidgets2 extends StatelessWidget {
  const ItemWidgets2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Column(
      children: [
        for (int i = 1; i < 8; i++)
          Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
               color: themeProvider.isDiurno ? Colors.white: themeColors[9],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context, "/detalle");
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(right: 15),
                    child: Image.asset("assets/lib1.jfif"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Perros Hambrientos",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                           color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
                        ),
                      ),
                    ),
                    Container(
                      width: 175,
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text("write description of product",style: TextStyle(color: themeProvider.isDiurno ? Colors.black87: Colors.grey,),)),
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                  color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[0],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                  BoxShadow(
                    color: themeProvider.isDiurno ? Colors.black.withOpacity(0.5): themeColors[0],
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],),
                            child: Text(
                              "terror",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )),
                        SizedBox(width: 10),
                        Container(
                            width: 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                  color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[0],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                  BoxShadow(
                     color: themeProvider.isDiurno ? Colors.black.withOpacity(0.5): themeColors[0],
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  )
                ],),
                            child: Text(
                              "accion",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[7],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
