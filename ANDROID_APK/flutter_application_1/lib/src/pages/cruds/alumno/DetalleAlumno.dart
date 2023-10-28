import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/AlumnoController.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/AlumnoList.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/EditAlumno.dart';


// ignore: must_be_immutable
class DetalleAlumno extends StatefulWidget {
  late List list;
  late int index;
  DetalleAlumno({required this.index, required this.list});

  @override
  State<DetalleAlumno> createState() => _DetalleAlumnoState();
}

class _DetalleAlumnoState extends State<DetalleAlumno> {
  AlumnoController alumnoController = AlumnoController();

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlumnoList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

void confirm() {
  final id = widget.list[widget.index]['id'].toString();
  final fotoURL = widget.list[widget.index]['foto'].toString();

  AlertDialog alertDialog = AlertDialog(
    content: Text("¿Está seguro de eliminar este alumno?  '$id'?"),
    actions: <Widget>[
      ElevatedButton(
        child: Text(
          "Eliminar",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () async {
          await alumnoController.removerAlumno(id, fotoURL);
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
        title: Text('Detalle Alumno'),
      ),
      drawer: MyDrawer(),
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
                  widget.list[widget.index]['nombre'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Text(
                  "Descripcion : ${widget.list[widget.index]['apellido']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                
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
                        builder: (BuildContext context) => EditAlumno(
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
