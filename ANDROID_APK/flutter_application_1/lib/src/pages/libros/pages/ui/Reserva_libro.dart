import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/search_component.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Libro_fisico.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/categoria/Item_categoria_seccion.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/widgets/inicioItem/ItemWidgets0.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ReservaLibro extends StatefulWidget {
  const ReservaLibro({super.key});

  @override
  State<ReservaLibro> createState() => _ReservaLibroState();
}

class _ReservaLibroState extends State<ReservaLibro> {
  late ThemeProvider themeProvider;
  late List<Color> themeColors;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Accede a los valores de Provider en didChangeDependencies
    themeProvider = Provider.of<ThemeProvider>(context);
    themeColors = themeProvider.getThemeColors();
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = context.watch<ThemeProvider>();
    // final themeColors = themeProvider.getThemeColors();
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
                height: 370,
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
                                        builder: (context) => LibroFisico()),
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
                        Container(
                          padding: EdgeInsets.only(left: 25),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                'Reserbar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
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
                                'Perros Hambrientos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.start,
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
                              SizedBox(height: 20),
                              _nota(),
                              SizedBox(height: 20),
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
                          child: Image.asset(
                            "assets/lib2.jfif",
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
                  //formulario
                  child: _formulario())
            ],
          ),
        ],
      ),
    );
  }

  Widget _textCenter() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Formulario",
            style: TextStyle(
              color:
                  themeProvider.isDiurno ? HexColor("#0e1b4d") : Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 70.0,
            color: themeProvider.isDiurno ? HexColor('#F82249') : Colors.white,
            height: 3.0,
          ),
        ],
      ),
    );
  }

  Widget _formulario() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textCenter(),
          SizedBox(height: 20),
          Text(
            'Usuario: Guino Elvis Yujra Vargas',
            style: TextStyle(
              color: themeProvider.isDiurno ? Colors.black : Colors.white,
            ),
          ),
          Text(
            'Codigo: 202100458',
            style: TextStyle(
              color: themeProvider.isDiurno ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              color: themeProvider.isDiurno ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              color: themeProvider.isDiurno ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              // Acción al enviar el formulario
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => themeProvider.isDiurno
                    ? HexColor("#F82249")
                    : themeColors[0],
              ),
            ),
            child: Text('Enviar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _nota() {
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDiurno ? HexColor("#F82249") : themeColors[0],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 85,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¡Recuerda!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 300,
                child: Text(
                  'Recuerda que las reservas de libros físicos sirven para apartar un ejemplar mientras visitas nuestra librería. ¡Estamos aquí para ayudarte a encontrar tu próxima lectura!',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
