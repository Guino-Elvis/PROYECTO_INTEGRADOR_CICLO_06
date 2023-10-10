import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/CategoriaController.dart';
import 'package:flutter_application_1/view/CategoriaList.dart';

class EditCategoria extends StatefulWidget {
  final List list;
  final int index;

  const EditCategoria({required this.list, required this.index});

  @override
  State<EditCategoria> createState() => _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  CategoriaController categoriaController = CategoriaController();

  late TextEditingController controllerid;
  late TextEditingController controllertitulo;
  late TextEditingController controllerdescripccion;
  late TextEditingController controllerfoto;

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriaList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllertitulo = TextEditingController(
        text: widget.list[widget.index]['titulo'].toString());
    controllerdescripccion = TextEditingController(
        text: widget.list[widget.index]['descripccion'].toString());
    controllerfoto = TextEditingController(
        text: widget.list[widget.index]['foto'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit categoria"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Visibility(
                  visible:
                      false, // Establece esta propiedad en false para ocultar el campo id.
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
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllertitulo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío"; // Mensaje de error
                      }
                      return null; // No hay error
                    },
                    decoration: InputDecoration(
                      hintText: "titulo",
                      labelText: "titulo",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerdescripccion,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío"; // Mensaje de error
                      }
                      return null; // No hay error
                    },
                    decoration: InputDecoration(
                      hintText: "descripccion",
                      labelText: "descripccion",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.black),
                  title: TextFormField(
                    controller: controllerfoto,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío"; // Mensaje de error
                      }
                      return null; // No hay error
                    },
                    decoration: InputDecoration(
                      hintText: "foto",
                      labelText: "foto",
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    categoriaController.editarCategoria(
                      controllerid.text.trim(),
                      controllertitulo.text.trim(),
                      controllerdescripccion.text.trim(),
                      controllerfoto.text.trim(),
                    );
                    _navigateList(context);
                  },
                  child: Text("Edit"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
