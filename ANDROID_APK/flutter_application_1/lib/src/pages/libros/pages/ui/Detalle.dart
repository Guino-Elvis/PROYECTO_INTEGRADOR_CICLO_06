import 'package:clippy_flutter/arc.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/detalle/ItemAppBar.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets2.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Detalle extends StatelessWidget {
  const Detalle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDECF2),
      body: ListView(
        children: [
          ItemAppbar(),
          Padding(
            padding: EdgeInsets.all(2),
            child: Container(
              margin: EdgeInsets.only(left: 80,right: 80,top: 20),
               padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(5, 5),
                  )
                ],
              ),
              child: Image.asset(
                "assets/lib1.jfif",
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Libro titulo",
                            style: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            maxRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 5),
                            itemBuilder: (context, _) => Icon(
                              Icons.favorite,
                              color: Color(0xFF4C53A5),
                              size: 20,
                            ),
                            onRatingUpdate: (index) {},
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Icon(
                                  Icons.download,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ExpandableText(
                        "Este código creará un texto expandible que mostrará  al principio y, cuando el usuario haga clic en él, se expandirá para mostrar el texto completo. También mostrará  para que el usuario pueda volver a contraer el texto si lo desea. Puedes ajustar el número de líneas maxLines según tus preferencias. ",
                        expandText: 'Leer más',
                        linkColor: Colors.red,
                        collapseText: 'Leer menos',
                        maxLines:
                            2, // Número de líneas a mostrar antes de mostrar "Leer más".
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Online:',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF4C53A5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 8,
                                          )
                                        ]),
                                    child: Text(
                                      "Si",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20), // Espacio entre los dos Row
                          Row(
                            children: [
                              Text(
                                'Category:',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF4C53A5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(),
                              Row(
                                children: [
                                  for (int i = 5; i < 8; i++)
                                    Container(
                                      height: 30,
                                      width: 60,
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                            )
                                          ]),
                                      child: Text(
                                        "terror",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Text(
              "Best Stilling",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          ItemWidgets2(),
        ],
      ),
    );
  }
}