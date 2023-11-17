import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Reserba_lib_Controller.dart';
import 'package:flutter_application_1/src/pages/cruds/reserva_lib/Reserva_list.dart';
import 'package:intl/intl.dart';

class CrearReserva extends StatefulWidget {
  @override
  State<CrearReserva> createState() => _CrearReservaState();
}

class _CrearReservaState extends State<CrearReserva> {
  ReservaLibController reservaLibController = ReservaLibController();

  List<Map<String, dynamic>> libros = [];
  String selectedLibro = ""; // Declaración de la variable

  LibroController libroController = LibroController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      print("Calling _getData");
      // final librosData =
      //     await libroController.getDataLibro();
      final librosData = await libroController.getDataLibro(formato: 'fisico');
      setState(() {
        libros = List<Map<String, dynamic>>.from(librosData);
      });
      print('Data fetched successfully. Number of items: ${libros.length}');
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController estado_reservaController =
      TextEditingController();
  final TextEditingController fecha_reservaController = TextEditingController();

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReservasList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

// Add this function to validate fields
  bool _validateFields() {
    if (userIdController.text.isEmpty ||
        selectedLibro == null ||
        selectedLibro.isEmpty ||
        selectedEstado == null ||
        selectedEstado!.isEmpty ||
        fecha_reservaController.text.isEmpty) {
      // Show a modal indicating that all fields must be filled.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Campos Incompletos"),
            content: Text(
                "Por favor, complete todos los campos antes de crear el Reserva."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  String?
      selectedEstado; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> estados = [
    'P',
    'A',
  ];
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Reserva'),
      ),
      body: BounceInRight(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SlideInUp(
            child: ListView(
              children: [
                TextFormField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    labelText: 'User',
                    hintText: 'User de Reserva',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
                DropdownButton<String>(
                  value: selectedLibro,
                  items: [
                    DropdownMenuItem<String>(
                      value: '',
                      child: Text('Seleccione Libro'),
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
                      selectedLibro = value!;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                 TextFormField(
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                        : '',
                  ),
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
                        fecha_reservaController.text =
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
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: selectedEstado,
                  onChanged: (String? newValue) {
                    // Aquí puedes manejar el cambio de valor seleccionado
                    setState(() {
                      selectedEstado = newValue;
                    });
                  },
                  items: estados.map((String estado_reserva) {
                    return DropdownMenuItem<String>(
                      value: estado_reserva,
                      child: Text(estado_reserva),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    hintText: 'Selecciona un Estado para el Reserva',
                    icon: Icon(Icons.category_outlined),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () async {
                      if (_validateFields()) {
                        if (selectedLibro != null) {
                          final libroId = int.tryParse(selectedLibro);
                          if (libroId != null) {
                            final libroSeleccionada = {
                              'id': libroId,
                            };
                            reservaLibController.crearReservaLib(
                              userIdController.text.trim(),
                              libroSeleccionada,
                              fecha_reservaController.text.trim(),
                              selectedEstado ?? "",
                            );
                            _navigateList(context);
                          } else {
                            print(
                                "Error: No se pudo convertir 'selectedlibro' a entero.");
                          }
                        } else {
                          print("Error: 'selectedlibro' es null");
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                50), // Agrega un BorderRadius de 10
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'CREAR',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                    width:
                        16), // Agrega un espacio entre el texto y el botón "Cancelar"
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reserva_crud');
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.red, // Color de fondo para el botón "Cancelar"
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
