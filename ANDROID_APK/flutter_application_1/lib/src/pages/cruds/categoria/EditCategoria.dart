import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/src/model/setup/Categoria_Lib_Model.dart';
import 'package:flutter_application_1/src/pages/cruds/categoria/CategoriaList.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditCategoria extends StatefulWidget {
  final List list;
  final int index;

  const EditCategoria({required this.list, required this.index});

  @override
  State<EditCategoria> createState() => _EditCategoriaState();
}

class _EditCategoriaState extends State<EditCategoria> {
  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();

  late TextEditingController controllerid;
  late TextEditingController controllertitulo;
  late TextEditingController controllerdescripcion;
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
        text: widget.list[widget.index]['titulo']?.toString() ?? '');
    controllerdescripcion = TextEditingController(
        text: widget.list[widget.index]['descripcion']?.toString() ?? '');
    categoriaImageURL = widget.list[widget.index]['foto'] ?? '';

    selectedImage = null; // Inicializa selectedImage como null
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      // Handle if the user cancels image selection
    }
  }

  Future<void> _updateImageInFirebase() async {
    String categoryId = controllerid.text.trim();
    String categoryTitle = controllertitulo.text.trim();

    String newImageUrl = widget.list[widget.index]['foto'] ?? "";

    if (selectedImage != null) {
      String fileName = 'categoriablog/$categoryId-$categoryTitle.png';
      final firebaseStorageReference =
          FirebaseStorage.instance.ref().child(fileName);

      try {
        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        if (downloadUrl != null) {
          newImageUrl = downloadUrl;
        } else {
          // Manejar el caso donde la URL de descarga es nula
        }
      } catch (e) {
        print("Error al cargar la imagen: $e");
      }
    }

    CategoriaLibModel updatedCategory = CategoriaLibModel(
      id: int.parse(categoryId),
      titulo: categoryTitle,
      descripcion: controllerdescripcion.text.trim(),
      foto: newImageUrl,
    );

    await categorialibControllerLib.editarCategoria(updatedCategory);

    _navigateList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Categoria"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                Visibility(
                  visible: false, // Establecer en false para ocultar
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
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: categoriaImageURL.isNotEmpty
                            ? categoriaImageURL
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
                      labelText: "titulo de la categoria",
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.black),
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
                      labelText: "Descripcion de la categoria",
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
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        _updateImageInFirebase();
                      },
                      child: Container(child: Text("Editar")),
                    ),
                    SizedBox(width: 16), // Agrega un espacio entre los botones
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/category');
                      },
                      child: Text("Cancelar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
