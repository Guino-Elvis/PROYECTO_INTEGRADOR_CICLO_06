import 'dart:convert';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/component/Actualizar.dart';
import 'package:flutter_application_1/src/component/BottomNavBarFlex2.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/config/ConfigApi.dart';
import 'package:flutter_application_1/src/controller/UsuarioController.dart';
import 'package:flutter_application_1/src/pages/cruds/usuario/CreateUsuario.dart';
import 'package:flutter_application_1/src/component/LeftNotifier.dart';
import 'package:flutter_application_1/src/pages/cruds/usuario/DetalleUsuarioo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:open_file/open_file.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class UsuarioList extends StatefulWidget {
  
  const UsuarioList({Key? key}) : super(key: key);
  
  @override
  State<UsuarioList> createState() => _UsuarioListState();
}

class _UsuarioListState extends State<UsuarioList> {
  
  late List<dynamic> data = [];
  UsuarioController usuarioController = UsuarioController();
  late File excelFile;

  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(ConfigApi.buildUrl('/auth/list')));
    final responseData = json.decode(response.body);

    // Itera sobre los elementos y convierte las fechas de cadenas a objetos DateTime
    for (var item in responseData) {
      if (item['created_at'] is String) {
        item['created_at'] = DateTime.parse(item['created_at']);
      }
      if (item['updated_at'] is String) {
        item['updated_at'] = DateTime.parse(item['updated_at']);
      }
      // Repite el proceso para otras fechas si es necesario.
    }

    return responseData;
  }

  // void actualizarVista(List<dynamic> newData) => getData().then((result) {
  //   Provider.of<Actualizar>(context, listen: false).setData(result);
  //   setState(() => data = result);
  // });

  void actualizarVista(List<dynamic> newData) {
  getData().then((result) {
    Provider.of<Actualizar>(context, listen: false).setData(result);
    setState(() => data = result);
  });
}

  Future<void> _navigateCrearUsuario(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUsuario()));
    if (result != null) {
      setState(() {});
    }
  }

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
  
    super.initState();
    initializeAsyncState();
  }

  Future<void> initializeAsyncState() async {
    final dir = await getApplicationDocumentsDirectory();
    excelFile = File('${dir.path}/data.xlsx');
    // Para ocultar las superposiciones de la interfaz de usuario (por ejemplo, la barra de estado y la barra de navegación)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
    getData().then((result) => setState(() => data = result));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar usuarios',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {},
                    ),
                  ),
                  style: TextStyle(color: HexColor("#060c22")),
                )
              : Text(
                  'Lista de Usuarios',
                  style: TextStyle(color: HexColor("#060c22"), fontWeight: FontWeight.bold),
                ),
          iconTheme: IconThemeData(color: HexColor("#060c22")),
          actions: <Widget>[
            IconButton(
              icon: Icon(isSearching ? Icons.close : Icons.search, color: HexColor("#060c22")),
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchController.clear(); // Limpia el campo de búsqueda cuando se cancela la búsqueda.
                  }
                });
              },
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/fondo3.jpg'), fit: BoxFit.cover),
                ),
                child: data.isEmpty ? Center(child: CircularProgressIndicator()) : ItemList(list: data, actualizarVista: actualizarVista, scaffoldContext: context),
              ),
            ),
            Container(
              height: 60.0, // Ajusta la altura deseada para el BottomNavBarFlex
              child: BottomNavBarFlex2(
                onPressedSpecialButtonItem: () {
                  _navigateCrearUsuario(context);
                },
                onPressedSpecialButtonExel: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmar descarga"),
                        content: Text("¿Seguro que quieres descargar este archivo?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el modal
                            },
                          ),
                          TextButton(
                            child: Text("Descargar"),
                            onPressed: () async {
                              Navigator.of(context).pop(); // Cierra el modal
                              try {
                                await usuarioController.exportDataToExcel();
                                print("Excel file saved and copied successfully");
                                // await OpenFile.open(excelFile.path); // Abre el archivo
                              } catch (e) {
                                // Manejo de excepciones aquí
                                print("Error al exportar o abrir el archivo Excel: $e");
                                // Puedes mostrar un mensaje al usuario si lo deseas
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Ocurrió un error al exportar o abrir el archivo Excel."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("Aceptar"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                onPressedSpecialButtonPdf: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmar descarga"),
                        content: Text("¿Seguro que quieres descargar este archivo PDF?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancelar"),
                            onPressed: () {
                              Navigator.of(context).pop(); // Cierra el modal
                            },
                          ),
                          TextButton(
                            child: Text("Descargar"),
                            onPressed: () async {
                              Navigator.of(context).pop(); // Cierra el modal
                              try {
                                await usuarioController.exportDataToPDF();
                                print("PDF file saved and copied successfully");
                                // Puedes abrir el archivo PDF aquí si lo deseas
                                // await OpenFile.open(pdfFile.path);
                              } catch (e) {
                                // Manejo de excepciones aquí
                                print("Error al exportar o abrir el archivo PDF: $e");
                                // Puedes mostrar un mensaje al usuario si lo deseas
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text("Ocurrió un error al exportar o abrir el archivo PDF."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text("Aceptar"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                buttonColor: HexColor("#F82249"),
              ),
            ),
          ],
        ),
      );
}

class ItemList extends StatelessWidget {
  final Function(List<dynamic>) actualizarVista;
  final List<dynamic> list;
  final UsuarioController usuarioController = UsuarioController();
  final BuildContext scaffoldContext; // Agrega un miembro para almacenar el contexto del Scaffold

  ItemList({Key? key, required this.list, required this.actualizarVista, required this.scaffoldContext}) : super(key: key);

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
                return SlideInUp(
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      leftNotifier.left += details.delta.dx;
                      leftNotifier.left = leftNotifier.left < -80 ? -80 : leftNotifier.left > 0 ? 0 : leftNotifier.left;
                    },
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! < 0) {
                        leftNotifier.showButton = true; // Mostrar el botón al detener el deslizamiento hacia la izquierda
                      }
                    },
                    child: Stack(
                      children: [
                        BounceInRight(
                          child: Transform.translate(
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
                              child: SlideInUp(
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
                                    Divider(color: HexColor("#F82249").withOpacity(0.8)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (leftNotifier.showButton)
                          BounceInRight(
                            child: Align(
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
                                              context: scaffoldContext,
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
                                                        usuarioController.removerUsuario(id, fotoURL).then((response) async {
                                                          if (response.statusCode == 200) {
                                                            ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(content: Text("Item eliminado con éxito.")));
                                                            // actualizarVista([]);
                                                              Navigator.of(scaffoldContext).pushNamed('/usuario');  // Navega a la otra ruta
                                                            //  actualizarVista(newData);
                                                          } else {
                                                            ScaffoldMessenger.of(scaffoldContext).showSnackBar(SnackBar(content: Text("Error al eliminar el item.")));
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
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
}
