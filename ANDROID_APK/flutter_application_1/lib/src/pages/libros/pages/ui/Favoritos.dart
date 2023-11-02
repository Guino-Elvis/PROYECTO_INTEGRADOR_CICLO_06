import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/favoritos/CartAppBar.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/favoritos/ItemFavoritosW.dart';
import 'package:provider/provider.dart';

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

  @override
  Widget build(BuildContext context) {
        final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();
    return Scaffold(
      body: Stack(
        children: [
          if (!themeProvider.isDiurno) // Condición para mostrar la imagen y el color encima
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondonegro1.jfif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
         if (!themeProvider.isDiurno) // Condición para mostrar el color encima de la imagen
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Color encima de la imagen
              ),
            ),
          ListView(
            children: [
              CartAppBar(),
              Container(
                // height: 700,
                padding:EdgeInsets.only(top:15),
                decoration: BoxDecoration(
                  color: themeProvider.isDiurno ? Colors.white: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35)
                  )
                ),
                child: Column(
                  children: [
                    ItemFavoritosW(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}