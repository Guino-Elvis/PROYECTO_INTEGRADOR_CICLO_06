import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class ItemAppbar extends StatelessWidget {
  const ItemAppbar({super.key});

  @override
  Widget build(BuildContext context) {
       final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      color: themeProvider.isDiurno ? HexColor("#0e1b4d"): Colors.transparent,
      //color: HexColor("#0e1b4d"),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/librohome");
              
            },
            child: Icon(
              Icons.arrow_back,
            color: Colors.white,
            size: 30,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20),
          child: Text(
            "Terror",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),),
          ),
          Spacer(),
          
           InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/favoritos");
                  },
                  child: Icon(
                    Icons.favorite_outline,
                    size: 25,
                    color: themeProvider.isDiurno ? HexColor("#F82249"): themeColors[7],
                  ),
                ),
        ],
      ),
    );
  }
}