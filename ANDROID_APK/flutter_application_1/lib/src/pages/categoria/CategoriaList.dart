// ignore_for_file: unnecessary_null_comparison, unused_local_variable
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/pages/categoria/CrearCategoriaPage.dart';
import 'package:flutter_application_1/src/pages/categoria/DetalleCategoria.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoriaList extends StatefulWidget {
  const CategoriaList({super.key});
  @override
  State<CategoriaList> createState() => _CategoriaListState();
}

class _CategoriaListState extends State<CategoriaList> {

  // late List<dynamic> data;
  late List<dynamic> data = [];


Future<List<dynamic>> getData() async {
  final response = await http.get(Uri.parse(ConfigApi.buildUrl('/categoriablog')));
  return json.decode(response.body);
}

  _navigateCrearCategoria(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CrearCategoriaPage()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((result) {
      setState(() {
        data = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorías'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(246, 104, 36, 24),
            ),
            onPressed: () => _navigateCrearCategoria(context),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // Cambia el color del icono aquí
          )
        ],
      ),
      drawer: MyDrawer(accountName: "Usuario"),
        // drawer: MyDrawer(accountName: "Nombre Usuario", accountEmail: "usuario@example.com"), // Aquí proporciona los datos necesarios
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ItemList(
              list: data,
            ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic> list;
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final titulo = item['titulo'].toString();
        final created_at =
            DateTime.parse(item['created_at'].toString()); // Parsear la fecha
        // Formatear la fecha como solo la fecha (sin la hora)
        final fechaFormateada = DateFormat('yyyy-MM-dd').format(created_at);

        final foto = item['foto']
            .toString(); // Asumiendo que 'foto' es la URL de la imagen

        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Container(
                  height: 100.0,
                  child: Card(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetalleCategoria(list: list, index: index)),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.visibility,
                              color: Colors.white,
                              size: 30.0, // Tamaño del icono
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                titulo,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                fechaFormateada,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Mostrar la imagen
                        // Container(
                        //   margin: EdgeInsets.all(8.0),
                        //   child: Image.network(
                        //     foto,
                        //     width: 80.0, // Ancho de la imagen
                        //     height: 80.0, // Alto de la imagen
                        //     fit:
                        //         BoxFit.cover, // Ajustar la imagen al contenedor
                        //   ),
                        // ),
                        // Mostrar la imagen

                        // Container(
                        //   margin: EdgeInsets.all(8.0),
                        //   child: foto != null
                        //       ? Image.network(
                        //           foto,
                        //           width: 80.0, // Ancho de la imagen
                        //           height: 80.0, // Alto de la imagen
                        //           fit: BoxFit
                        //               .cover, // Ajustar la imagen al contenedor
                        //         )
                        //       : Image.asset(
                        //           'assets/nofoto.jpg', // Ruta de la imagen predeterminada en tus assets
                        //           width: 80.0,
                        //           height: 80.0,
                        //           fit: BoxFit.cover,
                        //         ),
                        // ),
                        Padding(
                           padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // Forma circular
                              border: Border.all(
                                color: Colors.white, // Color del borde
                                width: 3.0, // Ancho del borde
                              ),
                            ),
                            clipBehavior: Clip
                                .antiAlias, // Recorta el contenido al círculo
                            child: CachedNetworkImage(
                              imageUrl: item.containsKey('foto')
                                  ? item['foto'].toString()
                                  : 'assets/nofoto.jpg',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset('assets/nofoto.jpg', width: 500.0),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
