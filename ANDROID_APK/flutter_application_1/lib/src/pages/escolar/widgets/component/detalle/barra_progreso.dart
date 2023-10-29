import 'package:flutter/material.dart';

class BarraProgreso extends StatelessWidget {
  const BarraProgreso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Text('Avance del curso 48%',style: TextStyle(color: Colors.white),),
          LinearProgressIndicator(
            minHeight: 10,
            borderRadius: BorderRadius.circular(20),
            backgroundColor: Colors.grey, // Color de fondo de la barra de progreso
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red), // Color de la barra de progreso
            value: 0.5, // Valor de progreso (de 0.0 a 1.0)
          ),
        ],
      ),
    );
  }
}