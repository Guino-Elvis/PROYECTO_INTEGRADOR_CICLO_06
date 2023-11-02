import 'package:flutter/material.dart';

class ItemCategoriaSeccion extends StatelessWidget {
  const ItemCategoriaSeccion({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)
              
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                   width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                 
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/detalle");
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/lib2.jfif",
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre la imagen y el texto
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título del libro o descripción',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Autor o información adicional',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
