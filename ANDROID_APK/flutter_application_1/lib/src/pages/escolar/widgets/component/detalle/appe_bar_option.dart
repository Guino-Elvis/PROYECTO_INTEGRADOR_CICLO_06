import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionBarEscuela extends StatelessWidget {
  const OptionBarEscuela({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      child: Center(
        child: Container(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Alinea los elementos a la derecha
            children: [
              Column(
                children: [
                  Icon(Icons.person,color:Colors.white ,size: 20,),
                  Text(
                    '35',
                    style: TextStyle(color: Colors.white,fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(
                          90), // Ajusta el radio según lo necesites
                    ),
                    padding: EdgeInsets.all(0.1),
                   
                    child: Icon(Icons.play_arrow_rounded,color: Colors.white,size: 15,),
                  ),
                  Text(
                    '35',
                  style: TextStyle(color: Colors.white,fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Icon(Icons.picture_as_pdf,color:Colors.white ,size: 20,),
                  Text(
                    '35',
                   style: TextStyle(color: Colors.white,fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Icon(CupertinoIcons.globe,color:Colors.white ,size: 20,),
                  Text(
                    '35',
                    style: TextStyle(color: Colors.white,fontSize: 10),
                  )
                ],
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
