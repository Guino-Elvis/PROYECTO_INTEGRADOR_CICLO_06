import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ButtombarWidgets extends StatefulWidget {
  @override
  _ButtombarWidgetsState createState() => _ButtombarWidgetsState();
}

class _ButtombarWidgetsState extends State<ButtombarWidgets> {

  @override
  Widget build(BuildContext context) {
    return  CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        onTap:(index){},
        height: 55.0,
        animationDuration:Duration(milliseconds: 300),
        color: Color(0xFF4C53A5),
        items: [
          Icon(Icons.bar_chart,size:25, color: Colors.white,),
           Icon(Icons.home,size:25, color: Colors.white,),
            Icon(Icons.settings,size:25, color: Colors.white,),
        ],
       );
      
  }
}