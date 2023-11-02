import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
        final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Container(
      color: themeProvider.isDiurno ? Colors.white: Colors.transparent,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/librohome");
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20,),
            child: Text(
              "Favoritos",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],
              ),
            ),
          ),
          Spacer(),
          Icon(Icons.more_vert,
          size: 30,
          color: themeProvider.isDiurno ? HexColor("#0e1b4d"): themeColors[7],)
        ],
      ),
    );
  }
}