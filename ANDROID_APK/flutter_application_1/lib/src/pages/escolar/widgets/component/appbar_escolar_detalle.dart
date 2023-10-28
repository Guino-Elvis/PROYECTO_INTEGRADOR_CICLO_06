import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class AppbarEscolarDetalle extends StatelessWidget {
  const AppbarEscolarDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#0e1b4d"),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/colegiohome");
              
            },
            child: Icon(
              Icons.arrow_back,
            color: HexColor('#F82249'),
            size: 30,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20),
          child: Text(
            "",
            style: TextStyle(
              color: HexColor('#F82249'),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),),
          ),
          Spacer(),
          Icon(Icons.notifications_none,
          color: HexColor('#F82249'),
          size: 30,)
        ],
      ),
    );
  }
}