import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controller/setup/Colegio/Inscripccion_colegio_controller.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/component/gridCursosIncripcion/cuadricula_escolar.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/Detalle_screen_escolar.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Seccion3Escolar extends StatefulWidget {
  const Seccion3Escolar({Key? key}) : super(key: key);

  @override
  State<Seccion3Escolar> createState() => _Seccion3EscolarState();
}

class _Seccion3EscolarState extends State<Seccion3Escolar> {
  final IncripcionController _incripcionController = IncripcionController();
  List<Map<String, dynamic>> _inscripciones = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() async {
    final inscripciones = await _incripcionController.getInscripccions();
    setState(() {
      _inscripciones = inscripciones;
    });
  }

  bool isGrid = false; // Controla la visualización inicial

  Widget _buildListView(BuildContext context) {
    return _listaItem(context);
  }

  Widget _listaItem(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      // color: Colors.green,
      child: Column(
        children: _inscripciones.map((inscripcion) {
          final detalleItems = inscripcion['detalle'];

          return Column(
            children: [
              // Container(
              //   child: Text('Inscripción ID: ${inscripcion['id']}'),
              // ),
              // Container(
              //   child: Text('user ID: ${inscripcion['userId']}'),
              // ),
              for (var detalleItem in detalleItems)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleEscolar(
                          nombreCurso: detalleItem['curso'] != null &&
                                  detalleItem['curso'].containsKey('nombre')
                              ? detalleItem['curso']['nombre'].toString()
                              : '',
                         cursoId: detalleItem['curso'] != null &&
                                  detalleItem['curso'].containsKey('id')
                              ? detalleItem['curso']['id'].toString()
                              : '',
                         
                          nombreDocente: detalleItem['docente'] != null &&
                                  detalleItem['docente'].containsKey('nombre')
                              ? '${detalleItem['docente']['nombre']} ${detalleItem['docente']['apellido']}'
                              : '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding:
                        EdgeInsets.all(0), // Sin relleno para eliminar márgenes
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: detalleItem['curso'] != null &&
                                          detalleItem['curso']
                                              .containsKey('foto')
                                      ? detalleItem['curso']['foto'].toString()
                                      : 'assets/nofoto.jpg',
                                  placeholder: (context, url) => Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/nofoto.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  color: HexColor("#0e1b4d").withOpacity(0.9),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${detalleItem['curso']['nombre']}',
                                  style: TextStyle(
                                    color: HexColor("#080C1E").withOpacity(0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'Ciclo VI - G1',
                                  style: TextStyle(
                                    color: HexColor("#F82249"),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Divider(
                                  color: HexColor("#080C1E").withOpacity(0.8),
                                ),
                                Text(
                                  '${detalleItem['docente']['nombre']}${detalleItem['docente']['apellido']}',
                                  style: TextStyle(
                                    color: HexColor("#080C1E").withOpacity(0.8),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitle(),
              _buildIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(left: 65),
      child: Column(
        children: [
          Text(
            "Courses",
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

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: InkWell(
        onTap: () {
          setState(() {
            // Cambia entre la visualización de cuadrícula y lista
            isGrid = !isGrid;
          });
        },
        child: Icon(isGrid
            ? Icons.grid_on
            : Icons.list), // Cambia los íconos según el estado
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridViewEscolar();
  }

  Widget _buildBody(BuildContext context) {
    return isGrid ? _buildGridView(context) : _buildListView(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTitleSection(),
          SizedBox(height: 50),
          _buildBody(
              context), // Utiliza la función _buildBody para mostrar la vista adecuada
        ],
      ),
    );
  }
}
