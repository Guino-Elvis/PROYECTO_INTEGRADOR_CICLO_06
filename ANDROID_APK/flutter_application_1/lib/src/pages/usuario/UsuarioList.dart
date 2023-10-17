import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/pages/usuario/CreateUsuario.dart';
import 'package:flutter_application_1/src/pages/usuario/DetalleUsuario.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsuarioList extends StatefulWidget {
  const UsuarioList({super.key});
  @override
  State<UsuarioList> createState() => _UsuarioListState();
  
}

class _UsuarioListState extends State<UsuarioList> {
  

  // late List<dynamic> data;
  late List<dynamic> data = [];


Future<List<dynamic>> getData() async {
  final response = await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
  return json.decode(response.body);
}

  _navigateCrearUsuario(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateUsuario()),
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
        title: Text('Lista de Usuarios'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(246, 104, 36, 24),
            ),
            onPressed: () => _navigateCrearUsuario(context),
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

    String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        final name = truncateString(item['name']?.toString() ?? 'Nombre no especificado', 15);
        final email = truncateString(item['email']?.toString() ?? 'Email no especificado', 15);
        // final name = item['name']?.toString() ?? 'Nombre no especificado';
        // final email = item['email']?.toString()?? 'email no especificado';
        final created_at = item['created_at'] != null
            ? DateTime.parse(item['created_at'].toString())
            : DateTime.now(); // Establece la fecha actual si es nula
        final fechaFormateada = DateFormat('yyyy-MM-dd').format(created_at);
        // Verifica si el campo 'foto' está presente y no es nulo
        final foto = item.containsKey('foto') && item['foto'] != null
            ? item['foto'].toString()
            : 'assets/nofoto.jpg';
            
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
                                    DetalleUsuario(list: list, index: index)),
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
                                name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                email,
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

                        Padding(
                          padding: const EdgeInsets.all(1.0),
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
