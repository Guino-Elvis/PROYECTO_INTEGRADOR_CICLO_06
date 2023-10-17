import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/UsuarioController.dart';
import 'package:flutter_application_1/src/pages/usuario/EditUsuario.dart';
import 'package:flutter_application_1/src/pages/usuario/UsuarioList.dart';


class DetalleUsuario extends StatefulWidget {
  late List list;
  late int index;
  DetalleUsuario({required this.index, required this.list});

  @override
  State<DetalleUsuario> createState() => _DetalleUsuarioState();
}

class _DetalleUsuarioState extends State<DetalleUsuario> {
  UsuarioController usuarioController = UsuarioController();

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

void confirm() {
  final id = widget.list[widget.index]['id'].toString();
  final fotoURL = widget.list[widget.index]['foto'].toString();

  AlertDialog alertDialog = AlertDialog(
    content: Text("¿Está seguro de eliminar este usuario? '$id'?"),
    actions: <Widget>[
      ElevatedButton(
        child: Text(
          "Eliminar",
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(primary: Colors.red),
        onPressed: () async {
          await usuarioController.removerUsuario(id, fotoURL);
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
        title: Text('Detalle del Usuario'),
      ),
      drawer: MyDrawer(accountName: "Usuario"),
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
                  widget.list[widget.index]['name'],
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Text(
                  "Email : ${widget.list[widget.index]['email']}",
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
                        builder: (BuildContext context) => EditUsuario(
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
