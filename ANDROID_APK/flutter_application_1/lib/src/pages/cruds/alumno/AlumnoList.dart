import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/component/user/drawer/drawers.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/CreateAlumnoPage.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/DetalleAlumno.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AlumnoList extends StatefulWidget {
  const AlumnoList({Key? key}) : super(key: key);
  // const AlumnoList({super.key});
  @override
  State<AlumnoList> createState() => _AlumnoListState();
}

class _AlumnoListState extends State<AlumnoList> {
  // late List<dynamic> data;
  late List<dynamic> data = [];

// Future<List<dynamic>> getData() async {
//   final response = await http.get(Uri.parse(ConfigApi.buildUrltoken('/alumno')));
//   return json.decode(response.body);
// }

  Future<List<dynamic>> getData() async {
    final authResponse = await ShareApiTokenService.loginDetails();
    if (authResponse != null) {
      final token = authResponse.token;
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse(ConfigApi.buildUrl('/alumno'));
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        return json.decode(response.body);
      }
    }

    return []; // Otra acción que consideres apropiada si el token no está disponible.
  }

  _navigateCrearAlumno(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateAlumnoPage()),
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
        title: Text('Lista de Alumnos'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(246, 104, 36, 24),
            ),
            onPressed: () => _navigateCrearAlumno(context),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            // Cambia el color del icono aquí
          )
        ],
      ),
      drawer: NavigationDrawerWidget(),
      // drawer: MyDrawer(accountName: "Nombre Usuario", accountEmail: "usuario@example.com"), // Aquí proporciona los datos necesarios
      // ignore: unnecessary_null_comparison
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
        final nombre = item['nombre'].toString();
        // ignore: unused_local_variable
        final apellido = item['apellido'].toString();
        final created_at =
            DateTime.parse(item['created_at'].toString()); // Parsear la fecha
        // Formatear la fecha como solo la fecha (sin la hora)
        final fechaFormateada = DateFormat('yyyy-MM-dd').format(created_at);

        // ignore: unused_local_variable
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
                                    DetalleAlumno(list: list, index: index)),
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
                                nombre,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                ),
                              ),
                              // Text(
                              //   apellido,
                              //   style: TextStyle(
                              //     fontSize: 20.0,
                              //     color: Colors.black87,
                              //   ),
                              // ),
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
                            )
                            ,
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
