import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/component/bottomNavigationBar.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/pages/usuario/CreateUsuario.dart';
import 'package:flutter_application_1/src/pages/usuario/DetalleUsuario.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class UsuarioList extends StatefulWidget {
  const UsuarioList({super.key});
  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {
  // late List<dynamic> data;
  late List<dynamic> data = [];

  Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
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
       title: Text(
        'Lista de Usuarios',
        style: TextStyle(color: HexColor("#060c22"),fontWeight:FontWeight.bold), // Cambia el color del texto en la AppBar
      ),
      iconTheme: IconThemeData(
        color: HexColor("#060c22")
      ),
    ),
    drawer: MyDrawer(accountName: "Usuario"),
    // drawer: MyDrawer(accountName: "Nombre Usuario", accountEmail: "usuario@example.com"), // Aquí proporciona los datos necesarios
      body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/fondo3.jpg'), // Ruta de la imagen
      fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
    ),
  ),
  child: data == null
    ? Center(
        child: CircularProgressIndicator(),
      )
    : ItemList(
        list: data,
      ),
),
 bottomNavigationBar: MyBottomAppBar(
      onPressedSpecialButton: () {
       _navigateCrearUsuario(context);
      },
      specialButtonColor: Colors.red, // Color personalizado para esta pantalla
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
        final role = truncateString(
            item['role']?.toString() ?? 'Role no especificado', 15);
        final email = truncateString(
            item['email']?.toString() ?? 'Email no especificado', 15);
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

        return Container(
          margin: EdgeInsets.all(10.0), // Agrega margen a todos los lados
          padding: EdgeInsets.all(10.0), // Agrega relleno a todos los lados
          decoration: BoxDecoration(
            color: Colors.white, // Fondo blanco
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
               color: HexColor("#0e1b4d").withOpacity(0.5), 
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Stack(
                  children: [
                    // Display the loading indicator when the image is being loaded
                    if (foto.isEmpty) CircularProgressIndicator(),
                    // Display the image if available, or the default asset image
                    if (foto.isNotEmpty)
                      CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(foto),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.blue,
                            width:
                                2.0, // Puedes ajustar el ancho del borde según tus necesidades
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/nofoto.jpg'), // Tu imagen de fondo
                          // Puedes ajustar el tamaño del CircleAvatar según tus necesidades
                        ),
                      ),
                  ],
                ),
                title: Text(
                  email,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: HexColor("#060c22"),fontWeight:FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha: $fechaFormateada'),
                    Text('Rol: $role'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.visibility,color: HexColor("#0e1b4d")),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DetalleUsuario(list: list, index: index),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: HexColor("#0e1b4d").withOpacity(0.8),),
            ],
          ),
        );
      },
    );
  }
}
