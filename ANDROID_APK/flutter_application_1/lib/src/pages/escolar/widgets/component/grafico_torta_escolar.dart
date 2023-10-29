import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class GraficoTorta extends StatelessWidget {
  const GraficoTorta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 4, // Hace que el gráfico tenga más ancho en comparación con las leyendas
            child: Stack(
              children: [
                Center(
                  child: PieChart(
                    PieChartData(
                      sections: getSections(),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 100,
                    child: Text(
                      '35 Evaluciones en total',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
            SizedBox(width: 20), // Separación entre el gráfico y la lista
          Expanded(
            flex: 4, // Ancho para las leyendas
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getLegend(),
            ),
          ),
        ],
      ),
    );
  }
  

  List<Widget> getLegend() {
    return List.generate(3, (i) {
      String title = '';
      Color color = Colors.transparent;

      switch (i) {
        case 0:
          title = '0 Evaluciones por completar';
          color = Colors.grey;
          break;
        case 1:
          title = '12 Evaluciones vencidos ';
          color = Colors.red;
          break;
        case 2:
          title = '23 Evaluciones completados';
          color = Colors.white;
          break;
      
        default:
          throw Error(); // En caso de que haya más secciones, se debe manejar el resto de los casos
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: color,
            ),
            SizedBox(width: 6),
            Container(
              width: 150,
              child: Text(title,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> getSections() {
    return List.generate(3, (i) {
      final isTouched = i == 1;
      final double fontSize = isTouched ? 12 : 15;
      final double radius = isTouched ? 20 : 20;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey,
            value: 2,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: HexColor('#F82249'),
            value: 12,
            title: '',
            radius: radius,
            // titleStyle: TextStyle(
            //   fontSize: fontSize,
            //   fontWeight: FontWeight.bold,
            //    color: HexColor('#F82249'),
            // ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.white,
            value: 23,
            title: '',
            radius: radius,
            // titleStyle: TextStyle(
            //   fontSize: fontSize,
            //   fontWeight: FontWeight.bold,
            //   color: const Color(0xffffffff),
            // ),
          );
       
        default:
          throw Error(); // En caso de que haya más secciones, se debe manejar el resto de los casos
      }
    });
  }
}
