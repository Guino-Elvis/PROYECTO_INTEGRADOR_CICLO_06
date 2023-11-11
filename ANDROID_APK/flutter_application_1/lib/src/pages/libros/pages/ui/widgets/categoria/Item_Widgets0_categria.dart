import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';

import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemWidgets0Categoria extends StatefulWidget {
  final dynamic categoria;
  // const CategoriView({Key? key, required categoria}) : super(key: key);
  const ItemWidgets0Categoria({Key? key, required this.categoria}) : super(key: key);

  @override
  _ItemWidgets0CategoriaState createState() => _ItemWidgets0CategoriaState();
}

class _ItemWidgets0CategoriaState extends State<ItemWidgets0Categoria> {
 
  @override
  Widget build(BuildContext context) {
     final dynamic categoria = widget.categoria;
        final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(23),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inicio()),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: themeProvider.isDiurno
                      ? HexColor('#F82249')
                      : Colors.white,
                  size: 30,
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/favoritos");
                },
                child: Icon(
                  Icons.favorite_outline,
                  size: 25,
                  //color: HexColor('#F82249'),
                  color: themeProvider.isDiurno
                      ? HexColor('#F82249')
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Text(
                'Categoria: ${categoria['titulo']?.toString() ?? 'no se encontró la categoria'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
          width: 170,
          child: Column(
            children: [
              Text(
                'Total de libros',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                '20',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
