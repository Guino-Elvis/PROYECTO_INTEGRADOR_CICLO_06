import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/controller/CategoriaController.dart';
import 'package:flutter_application_1/src/pages/categoria/CategoriaList.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

class EditCategoria extends StatefulWidget {
  final List list;
  final int index;

  const EditCategoria({required this.list, required this.index});

  @override
  State<EditCategoria> createState() => _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  CategoriaController categoriaController = CategoriaController();

  late TextEditingController controllerid;
  late TextEditingController controllertitulo;
  late TextEditingController controllerdescripccion;
  late TextEditingController controllerfoto;
  File? selectedImage;
  String categoriaImageURL = "";

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoriaList()),
    );

    if (result != null && result) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controllerid =
        TextEditingController(text: widget.list[widget.index]['id'].toString());
    controllertitulo = TextEditingController(
        text: widget.list[widget.index]['titulo'].toString());
    controllerdescripccion = TextEditingController(
        text: widget.list[widget.index]['descripccion'].toString());
    // Obtiene la URL de la imagen de la categoría que estás editando
    categoriaImageURL = widget.list[widget.index]['foto'];
    // Inicializa selectedImage con la URL de la foto existente
    selectedImage = File(categoriaImageURL);
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // El usuario no seleccionó una nueva imagen.
    }
  }

  Future<void> _updateImageInFirebase() async {
    String newImageUrl = widget.list[widget.index]
        ['foto']; // Por defecto, se mantiene la imagen existente

    if (selectedImage != null) {
      final firebaseStorageReference = FirebaseStorage.instance
          .ref()
          .child('categoriablog/${DateTime.now()}.png');

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl =
              downloadUrl; // Si se selecciona una nueva imagen, se actualiza la URL
        }
      } catch (e) {
        // Maneja el error, por ejemplo, muestra un mensaje al usuario
        print("Error al cargar la imagen: $e");
      }
    }

    // Actualiza la categoría, incluyendo la URL de la imagen (ya sea la existente o la nueva)
    categoriaController.editarCategoria(
      controllerid.text.trim(),
      controllertitulo.text.trim(),
      controllerdescripccion.text.trim(),
      newImageUrl,
    );

    _navigateList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit categoria"),
      ),
      drawer: MyDrawer(accountName: "Usuario"),
      // drawer: MyDrawer(
      //     accountName: "Nombre Usuario",
      //     accountEmail:
      //         "usuario@example.com"), // Aquí proporciona los datos necesarios
      body: Form(
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
                // Image.network(
                //   categoriaImageURL,
                //   width: 200, // Ajusta el tamaño según tus necesidades
                //   height: 200,
                //   fit: BoxFit
                //       .contain, // Puedes ajustar el ajuste según tus necesidades
                // ),

                Container(
                  margin: EdgeInsets.all(
                      8.0), // Agrega márgenes alrededor de la imagen
                  child: CachedNetworkImage(
                    imageUrl: categoriaImageURL.isNotEmpty
                        ? categoriaImageURL
                        : 'assets/nofoto.jpg',
                    placeholder: (context, url) =>
                        CircularProgressIndicator(), // Puedes personalizar el indicador de carga
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/nofoto.jpg'),
                    width: 80.0,
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
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
                      labelText: "titulo",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
                  title: TextFormField(
                    controller: controllerdescripccion,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacío";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "descripccion",
                      labelText: "descripccion",
                    ),
                  ),
                ),
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
                // ElevatedButton(
                //   onPressed: _pickImage,
                //   child: Container(child: Text("Cambiar Foto")),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.blueAccent,
                //   ),
                // ),

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
                    SizedBox(width: 16), // Agrega un espacio entre los botones
                    ElevatedButton(
                      onPressed: () {
                         Navigator.pushNamed(context, '/category'); // Navega a la ruta "categoria"
                      },
                      child: Text("Cancelar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Color de fondo para el botón "Cancelar"
                      ),
                    ),
                  ],
                )
                // ElevatedButton(
                //   onPressed: () {
                //     _updateImageInFirebase();
                //   },
                //   child: Text("Editar"),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.blueAccent,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
