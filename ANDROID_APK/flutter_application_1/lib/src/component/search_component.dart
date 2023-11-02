import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeProvider.isDiurno ? Colors.white : Colors.black,
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
      child: TextFormField(
        style: TextStyle(color: themeProvider.isDiurno ? Colors.black : Colors.white,), 
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Busca todo lo que quieras",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[7],
              //color: Colors.red,
            )),
      ),
    );
  }
}
