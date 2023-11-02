import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';


class ItemAppbar extends StatelessWidget {
  const ItemAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#0e1b4d"),
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
          Icon(Icons.favorite_border,
          color: HexColor('#F82249'),
          size: 30,)
        ],
      ),
    );
  }
}