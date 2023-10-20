// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/CategoriaController.dart';
import 'package:flutter_application_1/src/pages/categoria/CategoriaList.dart';
import 'package:flutter_application_1/src/pages/categoria/EditCategoria.dart';

class DetalleCategoria extends StatefulWidget {
  late List list;
  late int index;
  DetalleCategoria({required this.index, required this.list});

  @override
  State<DetalleCategoria> createState() => _DetalleCategoriaState();
}

class _DetalleCategoriaState extends State<DetalleCategoria> {
  CategoriaController categoriaController = CategoriaController();

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriaList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  // //create function delete
  // void confirm() {
  //   AlertDialog alertDialog = AlertDialog(
  //     content: Text(
  //         "¿Está seguro de eliminar esta categoría '${widget.list[widget.index]['id']}'?"),
  //     actions: <Widget>[
  //       ElevatedButton(
  //         child: Text(
  //           "Eliminar",
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         style: ElevatedButton.styleFrom(primary: Colors.red),
  //         onPressed: () {
  //           categoriaController
  //               .removerCategoria(widget.list[widget.index]['id'].toString());
  //           _navigateList(context);
  //         },
  //       ),
  //       ElevatedButton(
  //         child: Text(
  //           "Cancelar",
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         style: ElevatedButton.styleFrom(primary: Colors.green),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //     ],
  //   );

  //   showDialog(
  //       context: context, builder: (BuildContext context) => alertDialog);
  // }

void confirm() {
  final id = widget.list[widget.index]['id'].toString();
  final fotoURL = widget.list[widget.index]['foto'].toString();

  AlertDialog alertDialog = AlertDialog(
    content: Text("¿Está seguro de eliminar esta categoría '$id'?"),
    actions: <Widget>[
      ElevatedButton(
        child: Text(
          "Eliminar",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () async {
          await categoriaController.removerCategoria(id, fotoURL);
          _navigateList(context);
        },
      ),
      ElevatedButton(
        child: Text(
          "Cancelar",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );

  showDialog(
      context: context, builder: (BuildContext context) => alertDialog);
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Detalle Categoría'),
      ),
      drawer: MyDrawer(accountName: "Usuario"),
      // drawer: MyDrawer(accountName: "Nombre Usuario", accountEmail: "usuario@example.com"), // Aquí proporciona los datos necesarios
      body: new Container(
        height: 270.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  widget.list[widget.index]['titulo'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Text(
                  "Descripcion : ${widget.list[widget.index]['descripccion']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                // Container(
                //   margin: EdgeInsets.all(8.0),
                //   child: Image.network(
                //      widget.list[widget.index]['foto'],
                //     width: 80.0, // Ancho de la imagen
                //     height: 80.0, // Alto de la imagen
                //     fit: BoxFit.cover, // Ajustar la imagen al contenedor
                //   ),
                // ),
                // new Padding(
                //   padding: const EdgeInsets.only(top: 30.0),
                // ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("Edit"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => EditCategoria(
                          list: widget.list,
                          index: widget.index,
                        ),
                      )),
                    ),
                    VerticalDivider(),
                    ElevatedButton(
                      child: Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () => confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
