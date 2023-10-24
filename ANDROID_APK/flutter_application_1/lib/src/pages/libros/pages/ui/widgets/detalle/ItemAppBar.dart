import 'package:flutter/material.dart';


class ItemAppbar extends StatelessWidget {
  const ItemAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/librohome");
              
            },
            child: Icon(
              Icons.arrow_back,
            color: Color(0xFF4C53A5),
            size: 30,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20),
          child: Text(
            "Terror",
            style: TextStyle(
              color: Color(0xFF4C53A5),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),),
          ),
          Spacer(),
          Icon(Icons.favorite_border,
          color: Colors.red,
          size: 30,)
        ],
      ),
    );
  }
}