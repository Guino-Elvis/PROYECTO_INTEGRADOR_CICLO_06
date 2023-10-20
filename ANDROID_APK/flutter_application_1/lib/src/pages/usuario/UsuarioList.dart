import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Actualizar.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/component/bottomNavigationBar.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/controller/UsuarioController.dart';
import 'package:flutter_application_1/src/pages/usuario/CreateUsuario.dart';
import 'package:flutter_application_1/src/pages/usuario/DetalleUsuario.dart';
import 'package:flutter_application_1/src/component/LeftNotifier.dart';
import 'package:flutter_application_1/src/pages/usuario/DetalleUsuarioo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


class UsuarioList extends StatefulWidget {
  const UsuarioList({super.key});
  @override
  State<UsuarioList> createState() => _UsuarioListState();
  
}

class _UsuarioListState extends State<UsuarioList> {
  late List<dynamic> data = [];

 Future<List<dynamic>> getData() async {
    final response =
        await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
    return json.decode(response.body);
  }
  void actualizarVista(List<dynamic> newData) => getData().then((result) {
    Provider.of<Actualizar>(context, listen: false).setData(result);
    setState(() => data = result);
  });

  _navigateCrearUsuario(BuildContext context) async => (await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUsuario()))) != null ? setState(() {}) : null;

  @override
  void initState() {
    super.initState();
    getData().then((result) => setState(() => data = result));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Lista de Usuarios', style: TextStyle(color: HexColor("#060c22"), fontWeight: FontWeight.bold)),
      iconTheme: IconThemeData(color: HexColor("#060c22")),
    ),
    drawer: MyDrawer(accountName: "Usuario"),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/fondo3.jpg'), fit: BoxFit.cover),
      ),
      child: data == null ? Center(child: CircularProgressIndicator()) : ItemList(list: data, actualizarVista: actualizarVista),
    ),
    bottomNavigationBar: MyBottomAppBar(
      onPressedSpecialButton: () => _navigateCrearUsuario(context),
      specialButtonColor: Colors.red,
    ),
  );
}

class ItemList extends StatelessWidget {
  final Function(List<dynamic>) actualizarVista;
  final List<dynamic> list;
  final UsuarioController usuarioController = UsuarioController();

  ItemList({Key? key, required this.list, required this.actualizarVista}) : super(key: key);

  String truncateString(String text, int maxLength) => text.length <= maxLength ? text : text.substring(0, maxLength) + '...';

  double left = 0.0;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
      final item = list[index];
      final role = truncateString(item['role']?.toString() ?? 'Role no especificado', 15);
      final email = truncateString(item['email']?.toString() ?? 'Email no especificado', 15);
      final created_at = item['created_at'] != null ? DateTime.parse(item['created_at'].toString()) : DateTime.now();
      final fechaFormateada = DateFormat('yyyy-MM-dd').format(created_at);
      final foto = item.containsKey('foto') && item['foto'] != null ? item['foto'].toString() : 'assets/nofoto.jpg';

      return ChangeNotifierProvider<LeftNotifier>(
        create: (context) => LeftNotifier(),
        child: Consumer<LeftNotifier>(
          builder: (context, leftNotifier, child) {
            return GestureDetector(
              onHorizontalDragUpdate: (details) {
                leftNotifier.left += details.delta.dx;
                leftNotifier.left = leftNotifier.left < -80 ? -80 : leftNotifier.left > 0 ? 0 : leftNotifier.left;
              },
              child: Stack(children: [
                Transform.translate(
                  offset: Offset(leftNotifier.left, 0),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                              if (foto.isEmpty) CircularProgressIndicator(),
                              if (foto.isNotEmpty)
                                CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(foto),
                                )
                              else
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.blue, width: 2.0),
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage('assets/nofoto.jpg'),
                                  ),
                                ),
                            ],
                          ),
                          title: Text(
                            email,
                            style: TextStyle(color: HexColor("#060c22"), fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fecha: $fechaFormateada'),
                              Text('Rol: $role'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.visibility, color: HexColor("#0e1b4d")),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => DetalleUsuarioo(list: list, index: index),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(color: HexColor("#0e1b4d").withOpacity(0.8)),
                      ],
                    ),
                  ),
                ),
                if (leftNotifier.showButton)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 120.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                  size: 30,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Confirmación"),
                                        content: Text("¿Seguro que quieres eliminar este item?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: Text("Cancelar"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              final id = item['id'].toString();
                                              final fotoURL = item['foto'].toString();
                                              usuarioController.removerUsuario(id, fotoURL).then((response) {
                                                if (response.statusCode == 200) {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item eliminado con éxito.")));
                                                  actualizarVista([]);
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error al eliminar el item.")));
                                                }
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Eliminar"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            );
          },
        ),
      );
    },
  );
}