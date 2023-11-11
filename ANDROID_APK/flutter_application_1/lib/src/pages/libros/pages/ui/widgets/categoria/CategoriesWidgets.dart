import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:flutter_application_1/src/model/setup/CategoriaLibModel.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Categories_libro.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class CategoriItem1 extends StatefulWidget {
  const CategoriItem1({Key? key});

  @override
  State<CategoriItem1> createState() => _CategoriItem1State();
}

class _CategoriItem1State extends State<CategoriItem1> {
  List<dynamic> item = [];
  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  Future<void> _getData() async {
    try {
      final categoriesData =
          await categorialibControllerLib.getDataCategorialib();
      setState(() {
        item = categoriesData;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Login expirado. Vuelva a iniciar sesión por favor.'),
            actions: [
              TextButton(
                onPressed: () {
                  ShareApiTokenService.logout(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return BounceInUp(
      duration: Duration(milliseconds: 900),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: item.map<Widget>((items) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: themeProvider.isDiurno
                    ? HexColor("#F82249")
                    : themeColors[0],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(2, 0),
                  )
                ],
              ),
              child: InkWell(
               
                  onTap: () {
                     // Crear una instancia de la clase de modelo y pasarla a CategoriView
                  CategoriaLibModel categoriaLibModel = CategoriaLibModel(categoria: items);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      
                      builder: (context) => CategoriView(categoria: items),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      truncateText(
                          items['titulo']?.toString() ??
                              'no se encontró el titulo',
                          27),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
