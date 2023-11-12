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
  final int categoryId; // Cambiado el tipo de dynamic a int
  // const CategoriView({Key? key, required categoria}) : super(key: key);
  const CategoriView({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<CategoriView> createState() => _CategoriViewState();
}

class _CategoriViewState extends State<CategoriView> {
  late ThemeProvider themeProvider;
  late List<Color> themeColors;
  String categoryName = '';
  List<dynamic> item = []; // Lista para almacenar los libros
  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();
  Map<String, dynamic>? categoriaData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los valores de Provider en didChangeDependencies
    themeProvider = Provider.of<ThemeProvider>(context);
    themeColors = themeProvider.getThemeColors();
  }

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
      print('Fetching data for categoryId: ${widget.categoryId}');
      final librosCategoriaData =
          await categorialibControllerLib.getDataLibroPorIdCategoria(
        categoriaId: widget.categoryId,
        formato: 'online', // Agrega el formato aquí
      );

      // Nuevo: Obtener información de la categoría
      final categoriaResponse =
          await categorialibControllerLib.getCategoriaPorId(widget.categoryId);
      setState(() {
        item = librosCategoriaData;
        categoriaData = categoriaResponse;
      });

      // print('Data fetched successfully. Number of items: ${item.length}');
    } catch (error) {
      print('Error al obtener libros de la categoría: $error');
      // Aquí puedes mostrar un mensaje de error más detallado si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building CategoriView for categoryId: ${widget.categoryId}');
    print('Items in the list: $item');
    //  print('Number of items in the list: ${item.length}');
    // item.forEach((element) {
    //   print('Item: $element');
    // });
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
                        ? (categoriaData != null &&
                                categoriaData!['foto'] != null)
                            ? CachedNetworkImageProvider(
                                    categoriaData!['foto']!.toString())
                                as ImageProvider
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
                                'Categoría: ${categoriaData?['titulo'] ?? 'No encontrado'}',
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
                            imageUrl:
                                categoriaData?.containsKey('foto') ?? false
                                    ? categoriaData!['foto'].toString()
                                    : 'assets/nofoto.jpg',
                            placeholder: (context, url) => Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
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
                child: _itemCategoriaSeccion(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemCategoriaSeccion() {
    return Container(
      child: Column(
        children: item.map<Widget>((libroData) {
          //  print('Mapping libroData: $libroData');
          return _itemCategoriaSeccionComponent(libroData);
        }).toList(),
      ),
    );
  }

  Widget _itemCategoriaSeccionComponent(Map<String, dynamic> libroData) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.isDiurno ? Colors.black12 : themeColors[7],
            //color: Colors.black12
          ),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detalle(libro: libroData),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: libroData.containsKey('foto')
                      ? libroData['foto'].toString()
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
                  height: 130,
                  width: 85,
                ),
              ),
            ),
          ),
          SizedBox(width: 10), // Espacio entre la imagen y el texto
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateText(
                        libroData['titulo']?.toString() ??
                            'no se encontró el titulo',
                        27),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDiurno
                          ? HexColor("#0e1b4d")
                          : themeColors[7],
                    ),
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      truncateText(
                          libroData['descripcion']?.toString() ??
                              'no se encontró el descripcion',
                          70),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          'categoria:',
                          style: TextStyle(
                            color: themeProvider.isDiurno
                                ? HexColor("#0e1b4d")
                                : themeColors[7],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: themeProvider.isDiurno
                                  ? HexColor("#F82249")
                                  : themeColors[0],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: themeProvider.isDiurno
                                      ? Colors.black.withOpacity(0.5)
                                      : themeColors[0],
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              truncateText(
                                  libroData['categorialib']['titulo']
                                          ?.toString() ??
                                      'no se encontró la categoria',
                                  27),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        Text(
                          'formato:',
                          style: TextStyle(
                            color: themeProvider.isDiurno
                                ? HexColor("#0e1b4d")
                                : themeColors[7],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: themeProvider.isDiurno
                                  ? HexColor("#F82249")
                                  : themeColors[0],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: themeProvider.isDiurno
                                      ? Colors.black.withOpacity(0.5)
                                      : themeColors[0],
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                )
                              ],
                            ),
                            child: Text(
                              truncateText(
                                  libroData['formato']
                                          ?.toString() ??
                                      'no se encontró formato',
                                  27),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWidgets0Categoria() {
    // print('Number of items in _itemWidgets0Categoria: ${item.length}');
    return SlideInRight(
      duration: Duration(milliseconds: 900),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: item.map<Widget>((libroData) {
            //  print('Mapping libroData: $libroData');
            return _buildLibroContainer(libroData);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLibroContainer(Map<String, dynamic> libroData) {
    //print('Building container for libro: $libroData');
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
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detalle(libro: libroData),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: libroData.containsKey('foto')
              ? libroData['foto'].toString()
              : 'assets/nofoto.jpg',
          placeholder: (context, url) => Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
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
  }
}
