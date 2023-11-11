import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';



class ItemWidgets0LibFisico extends StatefulWidget {
  const ItemWidgets0LibFisico({Key? key}) : super(key: key);

  @override
  _ItemWidgets0LibFisicoState createState() => _ItemWidgets0LibFisicoState();
}

class _ItemWidgets0LibFisicoState extends State<ItemWidgets0LibFisico> {
  List<dynamic> item = []; // Lista para almacenar los libros
  LibroController libroController = LibroController();

  @override
  void initState() {
    super.initState();
    _getData();
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
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Login expirado . Vuelva a iniciar secion por favor .'),
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
    return SlideInRight(
       duration: Duration(milliseconds: 800),
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
                  // child: Image.asset(
                  //   'assets/lib2.jfif', // Asegúrate de que la estructura del libro coincida con lo que esperas
                  //   fit: BoxFit.cover,
                  //   height: 200,
                  //   width: 145,
                  // ),
                ),
              );
            }).toList(),
          ),
        ),
    );
  }
}
