import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Reserba_lib_Controller.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ReservaLibItem0 extends StatefulWidget {
  final String id;
  const ReservaLibItem0({Key? key, required this.id}) : super(key: key);
  @override
  State<ReservaLibItem0> createState() => _ReservaLibItem0State();
}

class _ReservaLibItem0State extends State<ReservaLibItem0> {
  late ThemeProvider themeProvider;
  late List<Color> themeColors;
  List<dynamic> item = [];
  late ReservaLibController reservaLibController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los valores de Provider en didChangeDependencies
    themeProvider = Provider.of<ThemeProvider>(context);
    themeColors = themeProvider.getThemeColors();
  }

  @override
  void initState() {
    super.initState();
    reservaLibController = ReservaLibController(); // Instanciar la clase
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
      final reservaData = await reservaLibController.getDataReserva();
      setState(() {
        item = reservaData;
      });
    } catch (error) {}
  }

  Future<void> _eliminarReserva(String id) async {
    try {
      var response = await reservaLibController.removerReservaLib(id);
      print("Respuesta del servidor: ${response.statusCode}");
      if (response.statusCode == 200) {
        // Actualizar la lista de reservas después de la eliminación
        setState(() {
          _getData();
        });
        // Puedes mostrar un mensaje de éxito aquí si es necesario
      } else {
        // Puedes mostrar un mensaje de error aquí si es necesario
        print("Error al eliminar la reserva");
      }
    } catch (e) {
      // Manejar errores generales, como problemas de red, etc.
      print("Error: $e");
    }
  }

  void _mostrarDetalleReserva(Map<String, dynamic> reserva) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detalles de la Reserva'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${reserva['id']}'),
            Text('Libro: ${reserva['libro']['titulo']}'),
            // Agrega más detalles según sea necesario
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: themeProvider.isDiurno ? Colors.white : Colors.black,
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
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _item1Reserba(),
            SizedBox(
              height: 12,
            ),
            _buildReservationItem()
          ],
        ));
  }

  Widget _item1Reserba() {
    return Center(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  themeProvider.isDiurno ? HexColor("#F82249") : themeColors[0],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      'ID',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 35),
                Column(
                  children: [
                    Text(
                      'Estado',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 45),
                Column(
                  children: [
                    Text(
                      'Libro',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 60),
                Column(
                  children: [
                    Text(
                      'Opciones',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                 SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationItem() {
    return Container(
      height: 300, // Ajusta la altura según tus necesidades
      child: ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          return _crudItem(item[index]);
        },
      ),
    );
  }

  Widget _crudItem(Map<String, dynamic> items) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: themeProvider.isDiurno ? Colors.white : Colors.white10,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          
          Column(
            children: [
              Text(
                truncateText(
                    items['id']?.toString() ?? 'no se encontró el id', 27),
                style: TextStyle(
                    color: themeProvider.isDiurno ? Colors.grey : Colors.white,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(width: 10),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.circle,
                  color: items['estado_reserva'] == 'A' ? Colors.green : Colors.grey,
            ),
            onSelected: (String result) {
              // Aquí puedes manejar la opción seleccionada del menú
              print('Seleccionado: $result');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'opcion1',
                child: Column(
                  children: [
                    Text(
                      truncateText(
                          items['estado_reserva']=='A'?'Aprobado':(items['estado_reserva']=='P'?'Pendiente':'No se encontró el estado').toString(),
                          27),
                      style: TextStyle(
                        color: Colors
                            .grey, // Puedes ajustar el color según tus necesidades
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Puedes agregar más elementos del menú según sea necesario
            ],
          ),
          Column(
            children: [
              Text(
                truncateText(
                    items['libro']['titulo']?.toString() ??
                        'no se encontró el id',
                    15),
                style: TextStyle(
                    color: themeProvider.isDiurno ? Colors.grey : Colors.white,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(width: 40),
          GestureDetector(
            onTap: () {
              _mostrarDetalleReserva(items);
            },
            child: Icon(
              CupertinoIcons.eye,
              color:
                  themeProvider.isDiurno ? HexColor("#0e1b4d") : Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 25),
          GestureDetector(
            onTap: () {
              // Mostrar un cuadro de diálogo de confirmación antes de eliminar
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Confirmar eliminación"),
                  content: Text(
                      "¿Estás seguro de que quieres eliminar esta reserva?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancelar"),
                    ),
                    TextButton(
                      onPressed: () {
                        _eliminarReserva(items['id'].toString());
                        Navigator.pop(context);
                      },
                      child: Text("Eliminar"),
                    ),
                  ],
                ),
              );
            },
            child: Icon(CupertinoIcons.delete,
                color:
                    themeProvider.isDiurno ? HexColor("#0e1b4d") : Colors.white,
                size: 20),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}
