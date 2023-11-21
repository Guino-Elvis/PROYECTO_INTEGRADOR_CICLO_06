import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/gird/asistencia/vista_asistencia.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/detalle/curso_detalle/gird/video/lista_detalle_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Seccion3EscolarDetalleAsistencia extends StatefulWidget {
  const Seccion3EscolarDetalleAsistencia({Key? key}) : super(key: key);

  @override
  State<Seccion3EscolarDetalleAsistencia> createState() => _Seccion3EscolarDetalleAsistenciaState();
}

class _Seccion3EscolarDetalleAsistenciaState extends State<Seccion3EscolarDetalleAsistencia> {
  bool isGrid = false; // Controla la visualización inicial

  Widget _buildTitleSection() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
          
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
     
      child: Column(
        children: [
          Text(
            "Asistencia",
            style: TextStyle(
              color: HexColor("#0e1b4d"),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 70.0,
            color: HexColor('#F82249'),
            height: 3.0,
          ),
        ],
      ),
    );
  }




  Widget _buildListView(BuildContext context) {
    return ListViewEscolarDetalleAsistencia();
  }

  Widget _buildBody(BuildContext context) {
    return  _buildListView(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTitleSection(),
          SizedBox(height: 50),
          _buildBody(context), // Utiliza la función _buildBody para mostrar la vista adecuada
        ],
      ),
    );
  }
}
