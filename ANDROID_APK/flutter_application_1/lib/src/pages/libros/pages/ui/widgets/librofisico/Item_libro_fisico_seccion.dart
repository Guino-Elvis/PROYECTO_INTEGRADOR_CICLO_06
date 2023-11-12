import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemLibroFisicoSeccion extends StatefulWidget {
  const ItemLibroFisicoSeccion({Key? key});

  @override
  State<ItemLibroFisicoSeccion> createState() => _ItemLibroFisicoSeccionState();
}

class _ItemLibroFisicoSeccionState extends State<ItemLibroFisicoSeccion> {
  List<dynamic> item = []; // Lista para almacenar los libros
  LibroController libroController = LibroController();

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
      // Llamada al método getDataLibro del controlador para obtener la lista de libros
      //final librosData = await libroController.getDataLibro();
      final librosData = await libroController.getDataLibro(formato: 'fisico');
      setState(() {
        item = librosData;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Login expirado . Vuelva a iniciar secion por favor .'),
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
    return FadeInLeft(
      duration: Duration(milliseconds: 600),
      child: Container(
        child: Column(
          children: item.map<Widget>((items) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.isDiurno
                        ? Colors.black12
                        : themeColors[7],
                    //color: Colors.black12
                  ),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detalle(libro: items),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: items.containsKey('foto')
                              ? items['foto'].toString()
                              : 'assets/nofoto.jpg',
                          placeholder: (context, url) => Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/nofoto.jpg',
                            height: 200,
                            width: 138,
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                          height: 200,
                          width: 138,
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
                            truncateText(
                                items['titulo']?.toString() ??
                                    'no se encontro el titulo',
                                35),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: themeProvider.isDiurno
                                  ? HexColor("#0e1b4d")
                                  : themeColors[7],
                            ),
                          ),
                          Text(
                            truncateText(
                                items['descripcion']?.toString() ??
                                    'no se encontro descripcion',
                                35),
                            style: TextStyle(color: Colors.grey),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                  'categoria:',
                                  style: TextStyle(
                                    color: themeProvider.isDiurno
                                        ? HexColor("#0e1b4d")
                                        : themeColors[7],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: themeProvider.isDiurno
                                          ? HexColor("#F82249")
                                          : themeColors[0],
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: themeProvider.isDiurno
                                              ? Colors.black.withOpacity(0.5)
                                              : themeColors[0],
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      truncateText(
                                          items['categorialib']['titulo']
                                                  ?.toString() ??
                                              'no se encontró la categoria',
                                          27),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                             SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          'formato:',
                          style: TextStyle(
                            color: themeProvider.isDiurno
                                ? HexColor("#0e1b4d")
                                : themeColors[7],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: themeProvider.isDiurno
                                  ? HexColor("#F82249")
                                  : themeColors[0],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: themeProvider.isDiurno
                                      ? Colors.black.withOpacity(0.5)
                                      : themeColors[0],
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              truncateText(
                                  items['formato']
                                          ?.toString() ??
                                      'no se encontró formato',
                                  27),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
