import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/search_component.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/categoria/Item_categoria_seccion.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';

import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class CategoriView extends StatefulWidget {
   final dynamic categoria;
  // const CategoriView({Key? key, required categoria}) : super(key: key);
   const CategoriView({super.key,this.categoria});

  @override
  State<CategoriView> createState() => _CategoriViewState();
}

class _CategoriViewState extends State<CategoriView> {
    List<dynamic> item = []; // Lista para almacenar los libros
  CategorialibControllerLib categorialibControllerLib = CategorialibControllerLib();
    

  @override
  void initState() {
    super.initState();
     _getData();
  }

  Future<void> _getData() async {
    try {
      final librosData = await categorialibControllerLib.getDataLibroPorIdCategoria(formato: 'online');
      
  
      setState(() {
        item = librosData;
      });
    } catch (error) {
      // Manejar errores, por ejemplo, mostrando un mensaje al usuario
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Login expirado . Vuelva a iniciar secion por favor .'),
            actions: [
              TextButton(
                onPressed: () {
                  ShareApiTokenService.logout(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final dynamic categoria = widget.categoria;
    final themeProvider = context.watch<ThemeProvider>();
    final themeColors = themeProvider.getThemeColors();

    return Scaffold(
      body: Stack(
        children: [
          if (!themeProvider
              .isDiurno) // Condición para mostrar la imagen y el color encima
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondonegro1.jfif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (!themeProvider
              .isDiurno) // Condición para mostrar el color encima de la imagen
            Positioned.fill(
              child: Container(
                color:
                    Colors.black.withOpacity(0.5), // Color encima de la imagen
              ),
            ),
          ListView(
            children: [
              Container(
                height: 565,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: themeProvider.isDiurno
                        ? categoria['foto'] != null
                            ? CachedNetworkImageProvider(
                                categoria['foto'].toString()) as ImageProvider
                            : AssetImage('assets/lib2.jfif')
                        : AssetImage('assets/fondonegro1.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: themeProvider.isDiurno
                            ? HexColor("#0e1b4d").withOpacity(0.8)
                            : Colors.black.withOpacity(0.5),
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
                                  color: themeProvider.isDiurno
                                      ? HexColor('#F82249')
                                      : Colors.white,
                                  size: 30,
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/favoritos");
                                },
                                child: Icon(
                                  Icons.favorite_outline,
                                  size: 25,
                                  //color: HexColor('#F82249'),
                                  color: themeProvider.isDiurno
                                      ? HexColor('#F82249')
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                'Categoria: ${categoria['titulo']?.toString() ?? 'no se encontró la categoria'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
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
                                '20',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
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
                          color: themeProvider.isDiurno
                              ? Colors.white
                              : Colors.white10,
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              SearchItem(),
                              SizedBox(height: 15),
                              _itemWidgets0Categoria(),
                            // ItemWidgets0Categoria(categoria: null,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
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
                          child: CachedNetworkImage(
                            imageUrl: categoria.containsKey('foto')
                                ? categoria['foto'].toString()
                                : 'assets/nofoto.jpg',
                            placeholder: (context, url) => Container(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/nofoto.jpg',
                              fit: BoxFit.cover,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: themeProvider.isDiurno ? Colors.white : Colors.white10,
                child: ItemCategoriaSeccion(),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _itemWidgets0Categoria() {
    return SlideInRight(
      duration: Duration(milliseconds: 900),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: item.map<Widget>((items) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(5, 5),
                  )
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detalle(libro: items),
                    ),
                  );
                },

                child: CachedNetworkImage(
                  imageUrl: items.containsKey('foto')
                      ? items['foto'].toString()
                      : 'assets/nofoto.jpg',
                  placeholder: (context, url) => Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/nofoto.jpg',
                    height: 200,
                    width: 138,
                    fit: BoxFit.cover,
                  ),
                  fit: BoxFit.cover,
                  height: 200,
                  width: 138,
                ),
              
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}
