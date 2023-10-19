import 'package:flutter/material.dart';

import 'package:flutter_application_1/src/controller/UsuarioController.dart';
import 'package:flutter_application_1/src/pages/usuario/EditUsuario.dart';
import 'package:flutter_application_1/src/pages/usuario/UsuarioList.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class DetalleUsuario extends StatefulWidget {
  final List list;
  final int index;
  DetalleUsuario({required this.index, required this.list});

  @override
  _DetalleUsuarioState createState() => _DetalleUsuarioState();
}

class _DetalleUsuarioState extends State<DetalleUsuario> {
  final UsuarioController usuarioController = UsuarioController();

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UsuarioList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del Usuario',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: HexColor("#0e1b4d"),
        toolbarHeight: 40.0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                margin: EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#0e1b4d").withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 30,
                                offset: Offset(0, 2),
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage('assets/fondo3.jfif'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Información del Usuario',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Información del Usuario',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Información del Usuario',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                         SizedBox(height: 20), // Espacio entre la información y el botón "Editar"
                        ElevatedButton(
                          child: Text("Editar"),
                          style: ElevatedButton.styleFrom(
                            primary: HexColor("#0e1b4d"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => EditUsuario(
                              list: widget.list,
                              index: widget.index,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
