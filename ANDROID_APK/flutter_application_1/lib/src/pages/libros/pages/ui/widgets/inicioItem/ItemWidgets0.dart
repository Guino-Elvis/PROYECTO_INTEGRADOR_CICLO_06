import 'package:flutter/material.dart';

class ItemWidgets0 extends StatelessWidget {
  const ItemWidgets0({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (int i = 1; i < 8; i++)
          Container(
            margin: EdgeInsets.all(10),
            // padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: Offset(5, 5),
                )
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/detalle");
              },
              child: Image.asset(
                "assets/lib2.jfif",
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
          ),
      ]),
    );
  }
}
