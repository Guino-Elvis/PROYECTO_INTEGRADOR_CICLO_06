import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controller/setup/Colegio/Asistencia_colegio_controller.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ListViewEscolarDetalleAsistencia extends StatefulWidget {
  const ListViewEscolarDetalleAsistencia({super.key});

  @override
  State<ListViewEscolarDetalleAsistencia> createState() =>
      _ListViewEscolarDetalleAsistenciaState();
}

class _ListViewEscolarDetalleAsistenciaState
    extends State<ListViewEscolarDetalleAsistencia> {
  final AsistenciaController _asistenciaController = AsistenciaController();

  List<Map<String, dynamic>> _asistencias = [];
  List<int> _cursos = [];
  int _selectedCurso = -1;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() async {
    final asistencias = await _asistenciaController.getAsistencias();
    Set<int> cursosSet = {};

    for (var asistencia in asistencias) {
      cursosSet.add(asistencia['cursoId']);
    }

    setState(() {
      _asistencias = asistencias;
      _cursos = cursosSet.toList();
      _selectedCurso = _cursos.isNotEmpty ? _cursos[0] : -1;
    });
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final formattedDate =
          "${dateTime.day}/${dateTime.month}/${dateTime.year % 100}";
      return formattedDate;
    } catch (e) {
      print('Error al formatear la fecha: $e');
      return 'Fecha inválida';
    }
  }

  void _filtrarPorCurso(int cursoId) {
    setState(() {
      _selectedCurso = cursoId;
    });
  }

  List<Map<String, dynamic>> _asistenciasFiltradas() {
    return _asistencias
        .where((asistencia) => asistencia['cursoId'] == _selectedCurso)
        .toList();
  }

  Widget _buildCursoButton(int cursoId, String cursoNombre) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => _filtrarPorCurso(cursoId),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _selectedCurso == cursoId ? Colors.red : HexColor("#0e1b4d"),
          ),
          child: Text(cursoNombre, style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildAsistenciasList() {
    return Column(
      children: _asistenciasFiltradas().map((asistencia) {
        final detalleItems = asistencia['detalle'];

        return Column(
          children: [
            for (var detalleItem in detalleItems)
              Center(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                                'Sesión ${asistencia['id'] != null ? asistencia['id'].toString() : 'N/A'}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                'Teoria',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(width: 35),
                          Column(
                            children: [
                              Text(
                                '${detalleItem['created_at'] != null ? _formatDate(detalleItem['created_at']) : 'Sin fecha'}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(width: 45),
                          Row(
                            children: [
                              Icon(
                                detalleItem['status'] == 1
                                    ? CupertinoIcons.check_mark
                                    : (detalleItem['status'] == 0
                                        ? Icons.close
                                        : Icons.error),
                                color: detalleItem['status'] == 1
                                    ? Colors
                                        .green // Color verde si el estado es 1 (check)
                                    : Colors
                                        .red, // Color rojo si el estado es 0 (close) o cualquier otro valor
                                size: 25,
                              ),
                              SizedBox(width: 10), // Ajusta según sea necesario
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _cursos.map((cursoId) {
                final curso = _asistencias.firstWhere(
                  (asistencia) => asistencia['cursoId'] == cursoId,
                  orElse: () => {
                    'cursoNombre': 'Sin nombre'
                  }, // Devolver un valor predeterminado
                );
                final cursoNombre = curso['cursoNombre'];

                return _buildCursoButton(cursoId, cursoNombre);
              }).toList(),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HexColor("#0e1b4d"),
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
                            'ID',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 86),
                      Column(
                        children: [
                          Text(
                            'Detalle',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          Text(
                            'Fecha',
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
                            'Asis',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          _buildAsistenciasList(),
        ],
      ),
    );
  }
}
