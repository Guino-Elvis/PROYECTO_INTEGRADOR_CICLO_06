import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class MyBottomAppBar extends StatelessWidget {

   final VoidCallback onPressedSpecialButton;
   final Color specialButtonColor; // Nuevo argumento para personalizar el color

   MyBottomAppBar({
    required this.onPressedSpecialButton,
    required this.specialButtonColor,
    });
    
@override
Widget build(BuildContext context) {
  return Container(
    height: 55.0, // Ajusta la altura deseada
    // color: Colors.brown, // Establece el color de fondo a café (marrón)
        decoration: BoxDecoration(
      color: HexColor("#0e1b4d").withOpacity(0.8),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0), // Radio en la esquina superior izquierda
        topRight: Radius.circular(15.0), // Radio en la esquina inferior izquierda
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButtonWithBackground(
          icon: Icons.home,
          onPressed: () {
            // Acción al hacer clic en el botón de inicio
          },
        ),
         _buildIconButtonWithBackground(
          icon: Icons.bar_chart,
          onPressed: () {
            // Acción al hacer clic en el botón de inicio
          },
        ),
        _buildCenterButton(), // Botón central especial
        _buildIconButtonWithBackground(
          icon: Icons.settings,
          onPressed: () {
            // Acción al hacer clic en el botón de configuración
          },
        ),

        _buildIconButtonWithBackground(
          icon: Icons.person,
          onPressed: () {
            // Acción al hacer clic en el botón de configuración
          },
        ),

      
      ],
    ),
  );
}

  Widget _buildIconButtonWithBackground({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        //  color: Colors.white,
        borderRadius: BorderRadius.circular(30), // Puedes ajustar el radio según tus preferencias
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey, // Puedes ajustar el color de la sombra
        //     blurRadius: 4, // Puedes ajustar el radio de la sombra
        //   ),
        // ],
      ),
      child: IconButton(
        icon: Icon(icon,color: Colors.white,),
        onPressed: onPressed,
      ),
    );
  }

Widget _buildCenterButton() {
  return Transform.translate(
    offset: Offset(0, -30), // Mueve el botón hacia arriba 30 píxeles
    child: Container(
      decoration: BoxDecoration(
         border: Border.all(
      color: Colors.white,
      width: 2.5, // Puedes ajustar el ancho del borde según tus preferencias
    ),
        color: specialButtonColor,
        borderRadius: BorderRadius.circular(90),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey,
        //     blurRadius: 4,
        //   ),
        // ],
      ),
      child: IconButton(
       
        icon: Icon(Icons.add, color: Colors.white,),
        onPressed: onPressedSpecialButton,
      ),
    ),
  );
}


  
}