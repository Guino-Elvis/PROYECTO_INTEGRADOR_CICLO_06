import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Reserba_lib_Controller.dart';
import 'package:flutter_application_1/src/pages/cruds/reserva_lib/Reserva_list.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class EditReserva extends StatefulWidget {
  final List list;
  final int index;

  const EditReserva({required this.list, required this.index});

  @override
  State<EditReserva> createState() => _EditReservaState();
}

class _EditReservaState extends State<EditReserva> {
  ReservaLibController reservaLibController = ReservaLibController();

  late TextEditingController controllerid;
  late TextEditingController controlleruserId;
  late TextEditingController controllerlibro;
  late TextEditingController controllerfecha_reserva;
  late TextEditingController controllerestado_reserva;

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservasList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controlleruserId = TextEditingController(
        text: widget.list[widget.index]['userId']?.toString() ??
            'userId no especificado');
    selectedLibrolib = widget.list[widget.index]['libro']['id'].toString();
    selectedEstado =
        widget.list[widget.index]['estado_reserva']?.toString() ?? "";
    controllerfecha_reserva = TextEditingController(
        text: widget.list[widget.index]['fecha_reserva']?.toString() ??
            'fecha_reserva no especificado');
  }

  String calculateMD5(File file) {
    final content = file.readAsBytesSync();
    final digest = md5.convert(content);
    return digest.toString();
  }

  Future<void> _updateReserva() async {
    String reservaId = controllerid.text.trim();

    Map<String, dynamic> selectedLibro = libros.firstWhere(
      (libro) => libro['id'].toString() == selectedLibrolib,
      orElse: () =>
          Map<String, dynamic>(), // Devuelve un mapa vacío si no se encuentra
    );

    // Asegúrate de que selectedLibro no sea null antes de pasarlo a editarLibro
    selectedLibro = selectedLibro.isNotEmpty ? selectedLibro : {'id': ''};

    reservaLibController.editarReservaLib(
      reservaId,
      controlleruserId.text.trim(),
      selectedLibro, // Objeto de categoría seleccionado
      controllerfecha_reserva.text.trim(),
      selectedEstado ?? "", // Rol seleccionado
    );

    _navigateList(context);
  }

  String?
      selectedEstado; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> estados = ['A', 'P'];
  DateTime? selectedDate;
  List<Map<String, dynamic>> libros = [];
  String? selectedLibrolib = ""; // Declaración de la variable

  LibroController libroController = LibroController();

  Future<void> _getData() async {
    try {
      print("Calling _getData");

      final librosData = await libroController.getDataLibro(formato: 'fisico');
      setState(() {
        libros = List<Map<String, dynamic>>.from(librosData);
      });
      print('Data fetched successfully. Number of items: ${libros.length}');
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Reserva"),
      ),
      body: SlideInUp(
        child: Form(
          child: BounceInRight(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      child: ListTile(
                        leading: Icon(Icons.title, color: Colors.black),
                        title: TextFormField(
                          controller: controllerid,
                          decoration: InputDecoration(
                            hintText: "id",
                            labelText: "id",
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controlleruserId,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "User",
                          labelText: "User de la reserva",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16.0, right: 20.0),
                      child: DropdownButton<String>(
                        value: libros.isNotEmpty
                            ? selectedLibrolib ?? libros[0]['id'].toString()
                            : '',
                        items: [
                          DropdownMenuItem<String>(
                            value: '', // Valor por defecto
                            child: Text(libros.isNotEmpty
                                ? libros[0]['titulo'].toString()
                                : ''),
                          ),
                          ...libros.map((libro) {
                            final id = libro['id'].toString();
                            final titulo = libro['titulo'];
                            return DropdownMenuItem<String>(
                              value: id,
                              child: Text(titulo ?? 'No Disponible'),
                            );
                          }).toList(),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedLibrolib = value!;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      // controller: TextEditingController(
                      //   text: selectedDate != null
                      //       ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      //       : '',
                      // ),
                      controller: controllerfecha_reserva,
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (date != null && date != selectedDate) {
                          setState(() {
                            selectedDate = date;
                            controllerfecha_reserva.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                        hintText: 'Fecha de Reserva',
                        icon: Icon(CupertinoIcons.book_solid),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 16.0,
                          right:
                              20.0), // Margen izquierdo para alinear visualmente con los otros campos
                      child: DropdownButtonFormField<String>(
                        value: selectedEstado,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedEstado = newValue;
                          });
                        },
                        items: estados.map((String estado) {
                          return DropdownMenuItem<String>(
                            value: estado,
                            child: Text(estado),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Estado',
                          hintText: 'Selecciona un estado para la reserva',
                          icon: Icon(Icons.category_outlined),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            _updateReserva();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservasList(),
                              ),
                            );
                          },
                          child: Container(child: Text("Editar")),
                        ),
                        SizedBox(
                            width: 16), // Agrega un espacio entre los botones
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/reserva_crud');
                          },
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
