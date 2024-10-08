import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/search_component.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets0.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/librofisico/ItemWidgets0_libfisico.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/librofisico/Item_libro_fisico_seccion.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class LibroFisico extends StatefulWidget {
  const LibroFisico({super.key});

  @override
  State<LibroFisico> createState() => _LibroFisicoState();
}

class _LibroFisicoState extends State<LibroFisico> {
  
   List<dynamic> item = []; // Lista para almacenar los libros
     LibroController libroController = LibroController();

      @override
  void initState() {
    super.initState();
    _getData();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  Future<void> _getData() async {
    try {
      // Llamada al método getDataLibro del controlador para obtener la lista de libros
      //final librosData = await libroController.getDataLibro();
      final librosData = await libroController.getDataLibro(formato: 'fisico');
      setState(() {
        item = librosData;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
     
    }
  }


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
            
              Container(
                height: 565,
                decoration: BoxDecoration(
                  image: DecorationImage(
                     image: themeProvider.isDiurno
              ? AssetImage('assets/lib2.jfif')
              : AssetImage('assets/fondonegro1.jfif'),
                    // image: AssetImage('assets/lib2.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
                  
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                           color: themeProvider.isDiurno ?HexColor("#0e1b4d").withOpacity(0.8): Colors.black.withOpacity(0.5),
                        // color: HexColor("#0e1b4d").withOpacity(0.8),
                        //  color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Container(
                          padding: EdgeInsets.all(23),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Inicio()),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                      color: themeProvider.isDiurno ? HexColor('#F82249'): Colors.white,
                                  size: 30,
                                ),
                              ),
                              Spacer(),
                              PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: InkWell(
                                      onTap: (){
                                          Navigator.pushNamed(context, "/favoritos");
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.bookmark,
                                            color: themeProvider.isDiurno
                                                ? HexColor('#F82249')
                                                : Colors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          Text('Mis Reservas'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Puedes agregar más elementos del menú aquí si es necesario
                                ],
                                child: Icon(
                                  Icons.more_vert,
                                  size: 25,
                                  color: themeProvider.isDiurno
                                      ? HexColor('#F82249')
                                      : Colors.white,
                                ),
                              ),
                               
                            ],
                          ),
                        ),
                         FadeInLeft(
                          duration: Duration(milliseconds: 600),
                           child: Container(
                            padding: EdgeInsets.only(left: 25),
                            alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(
                                    'Libro: Fisico',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                           ),
                         ),
                         SizedBox(height: 20,),
                         FadeInLeft(
                          duration: Duration(milliseconds: 600),
                           child: Container(
                            padding: EdgeInsets.only(left: 25),
                            alignment: Alignment.centerLeft,
                            width: 170,
                              child: Column(
                                children: [
                                 Text(
                                    'Total de libros',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                       ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                   '${item.length}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                           ),
                         ),
                       
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(40)),
                        child: Container(
                          padding: EdgeInsets.only(top: 15),
                            color: themeProvider.isDiurno ? Colors.white: Colors.white10,
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              SearchItem(),
                              SizedBox(height: 15),
                              ItemWidgets0LibFisico(),
                            ],
                          ),
                        ),
                      ),
                    ),
                     FadeInRight(
                       duration: Duration(milliseconds: 600),
                      child: Transform.translate(
                        offset: Offset(230, 70),
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2,
                                0.004) // Establecer un valor para la perspectiva
                            ..rotateY(0.3), // Girar en el eje Y
                          alignment: FractionalOffset.center,
                          child: Container(
                            width: 130,
                            height: 180,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/lib2.jfif",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                   color: themeProvider.isDiurno ? Colors.white: Colors.white10,
                child: ItemLibroFisicoSeccion(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
