import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/cruds/libro/libro_list.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

class EditLibro extends StatefulWidget {
  final List list;
  final int index;

  const EditLibro({required this.list, required this.index});

  @override
  State<EditLibro> createState() => _EditLibroState();
}

class _EditLibroState extends State<EditLibro> {
  LibroController libroController = LibroController();

  late TextEditingController controllerid;
  late TextEditingController controllertitulo;
  late TextEditingController controllerautor;
  late TextEditingController controllerisbn;
  late TextEditingController controllerdescripcion;
  late TextEditingController controllerdisponibilidad;
  late TextEditingController controllerformato;
  late TextEditingController controllerestado;
  late TextEditingController controllercategorialib;
  late TextEditingController controllerfoto;

  File? selectedImage;

  String libroImageURL = "";

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LibroList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
      _getData();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllertitulo = TextEditingController(
        text: widget.list[widget.index]['titulo']?.toString() ??
            'titulo no especificado');
    controllerautor = TextEditingController(
        text: widget.list[widget.index]['autor']?.toString() ??
            'autor no especificado');
    controllerisbn = TextEditingController(
        text: widget.list[widget.index]['isbn']?.toString() ??
            'codigo no especificado');
    controllerdescripcion = TextEditingController(
        text: widget.list[widget.index]['descripcion']?.toString() ??
            'descripcion no especificado');
    controllerdisponibilidad = TextEditingController(
        text: widget.list[widget.index]['disponibilidad']?.toString() ??
            'disponibilidad no especificado');
       selectedFormato = widget.list[widget.index]['formato']?.toString() ?? "";       
    // controllerformato = TextEditingController(
    //     text: widget.list[widget.index]['formato']?.toString() ??
    //         'formato no especificado');
    controllerestado = TextEditingController(
        text: widget.list[widget.index]['estado']?.toString() ??
            'estado no especificado');
     //selectedCategorialib = widget.list[widget.index]['categorialib']?.toString() ?? "";       
    selectedCategorialib = categorias.isNotEmpty ? categorias.first['id'].toString() : "";
    libroImageURL = widget.list[widget.index]['foto'] != null
        ? widget.list[widget.index]['foto'].toString()
        : 'assets/nofoto.jpg';

    selectedImage = File(libroImageURL);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {}
  }


  String calculateMD5(File file) {
    final content = file.readAsBytesSync();
    final digest = md5.convert(content);
    return digest.toString();
  }

  Future<void> _updateImageInFirebase() async {
    String newImageUrl = widget.list[widget.index]['foto'] ?? "";
    String libroId = controllerid.text.trim();
    String libroTitle = controllertitulo.text.trim();

    if (selectedImage != null) {

      String fileName = 'libro/$libroId-$libroTitle.png';

      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child(fileName);

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl = downloadUrl;
        } else {
        }
      } catch (e) {
        print("Error al cargar la imagen: $e");
      }
    }

    libroController.editarLibro(
      libroId,
      libroTitle,
      controllerautor.text.trim(),
      controllerisbn.text.trim(),
      controllerdescripcion.text.trim(),
      controllerdisponibilidad.text.trim(),
       selectedFormato ?? "", // Rol seleccionado
      //controllerformato.text.trim(),
      controllerestado.text.trim(),
      selectedCategorialib, // Rol seleccionado

      newImageUrl,
    );

    _navigateList(context);
  }
 String?
      selectedFormato; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> formatos = ['online', 'fisico'];


 List<Map<String, dynamic>> categorias = [];
   String? selectedCategorialib = ""; // Declaración de la variable

  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();

       Future<void> _getData() async {
    try {
      print("Calling _getData");
      final categoriesData = await categorialibControllerLib.getDataCategorialib();
      setState(() {
        categorias = List<Map<String, dynamic>>.from(categoriesData);
      });
      print('Data fetched successfully. Number of items: ${categorias.length}');
    } catch (error) {
      print("Error fetching data: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Libro"),
      ),
      body: SlideInUp(
        child: Form(
          child: BounceInRight(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      child: ListTile(
                        leading: Icon(Icons.title, color: Colors.black),
                        title: TextFormField(
                          controller: controllerid,
                          decoration: InputDecoration(
                            hintText: "id",
                            labelText: "id",
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4, // Define la elevación de la sombra negra
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Define la forma del Card
                      ),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8.0), // Hace que la imagen esté recortada con bordes redondeados
                          child: CachedNetworkImage(
                            imageUrl: libroImageURL.isNotEmpty
                                ? libroImageURL
                                : 'assets/nofoto.jpg',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/nofoto.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllertitulo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "titulo",
                          labelText: "titulo del libro",
                        ),
                      ),
                    ),
                     ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllerautor,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "autor",
                          labelText: "autor del libro",
                        ),
                      ),
                    ),
                     ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllerisbn,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Codigo",
                          labelText: "Codigo del libro",
                        ),
                      ),
                    ),
                     ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllerdescripcion,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Descripcion",
                          labelText: "Descripcion del libro",
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllerdisponibilidad,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Disponibilidad",
                          labelText: "Disponibilidad del libro",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:16.0,right: 20.0), // Margen izquierdo para alinear visualmente con los otros campos
                      child: DropdownButtonFormField<String>(
                        value: selectedFormato,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedFormato = newValue;
                          });
                        },
                        items: formatos.map((String formato) {
                          return DropdownMenuItem<String>(
                            value: formato,
                            child: Text(formato),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Formato',
                          hintText: 'Selecciona un formato para el libro',
                          icon: Icon(Icons.category_outlined),
                        ),
                      ),
                    ),
                    ListTile(
                        leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                      title: TextFormField(
                        controller: controllerestado,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El campo no puede estar vacío";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "estado",
                          labelText: "estado del libro",
                        ),
                      ),
                    ),
                     DropdownButton<String>(
  value: selectedCategorialib,
  items: [
    DropdownMenuItem<String>(
      value: '', // Valor por defecto
      child: Text('Seleccione Categoría'),
    ),
    ...categorias.map((categoria) {
      final id = categoria['id'].toString();
      final titulo = categoria['titulo'];
      return DropdownMenuItem<String>(
        value: id,
        child: Text(titulo ?? 'No Disponible'),
      );
    }).toList(),
  ],
  onChanged: (value) {
    setState(() {
      selectedCategorialib = value!;
    });
  },
),
                    //   ListTile(
                    //   leading: Icon(CupertinoIcons.book_solid, color: Colors.black),
                    //   title: TextFormField(
                    //     controller: controllercategorialib,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "El campo no puede estar vacío";
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //       hintText: "categoria",
                    //       labelText: "categoria del libro",
                    //     ),
                    //   ),
                    // ),
                    Divider(
                      height: 1.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Container(child: Text("Cambiar Foto")),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            _updateImageInFirebase();
                          },
                          child: Container(child: Text("Editar")),
                        ),
                        SizedBox(
                            width: 16), // Agrega un espacio entre los botones
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/category');
                          },
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
