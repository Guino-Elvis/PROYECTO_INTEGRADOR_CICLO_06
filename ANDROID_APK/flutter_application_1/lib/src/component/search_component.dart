import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
