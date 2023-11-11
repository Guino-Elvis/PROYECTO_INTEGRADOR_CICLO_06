import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ItemWidgets2 extends StatefulWidget {
  const ItemWidgets2({Key? key}) : super(key: key);

  @override
  State<ItemWidgets2> createState() => _ItemWidgets2State();
}

class _ItemWidgets2State extends State<ItemWidgets2> {
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
      final libroData = await libroController.getDataLibro(formato: 'online');
      setState(() {
        item = libroData;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Login expirado . Vuelva a iniciar secion por favor .'),
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
    return Column(
      children: item.map<Widget>((items) {
        //  for (int i = 1; i < 8; i++)
        return Container(
          height: 130,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: themeProvider.isDiurno ? Colors.white : themeColors[9],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                 onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detalle(libro: items),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 15),
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
                      height: 120,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                    height: 120,
                    width: 80,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                   
                    alignment: Alignment.centerLeft,
                    child: Text(
                       truncateText(items['titulo']?.toString() ?? 'no se encontró el título', 35),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDiurno
                            ? HexColor("#0e1b4d")
                            : themeColors[7],
                      ),
                    ),
                  ),
                  Container(
                    width: 175,
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                         truncateText(items['descripcion']?.toString() ?? 'no se encontró la descripccion', 30),
                          //items['descripcion']?.toString() ?? 'no se encontró la descripccion',
                          style: TextStyle(
                            color: themeProvider.isDiurno
                                ? Colors.black87
                                : Colors.grey,
                          ),
                        )),
                  
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text('categoria:',style: TextStyle(
                          color: themeProvider.isDiurno
                          ? HexColor("#0e1b4d")
                          : themeColors[7],
                        ),),
                        SizedBox(width: 10,),
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
                             truncateText(items['categorialib']['titulo']?.toString() ?? 'no se encontró la categoria',27),
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
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      color: themeProvider.isDiurno
                          ? HexColor("#F82249")
                          : themeColors[7],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
