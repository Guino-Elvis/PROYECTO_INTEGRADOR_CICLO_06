import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/Categoria_Lib_Controller.dart';
import 'package:flutter_application_1/src/controller/setup/Biblioteca/LibroController.dart';
import 'package:flutter_application_1/src/pages/cruds/libro/libro_list.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CrearLibro extends StatefulWidget {
  @override
  State<CrearLibro> createState() => _CrearLibroState();
}

class _CrearLibroState extends State<CrearLibro> {
  LibroController libroController = LibroController();

  List<Map<String, dynamic>> categorias = [];
   String selectedCategoria = ""; // Declaración de la variable

  CategorialibControllerLib categorialibControllerLib =
      CategorialibControllerLib();

  @override
  void initState() {
    super.initState();
    _getData();
  }

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

  final TextEditingController tituloController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController disponibilidadController =
      TextEditingController();
  final TextEditingController formatoController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();


  File? selectedImage;

  _navigateList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LibroList()),
    );

    if (result != null && result) {
      setState(() {});
    }
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

  Future<String?> _uploadImage(String libroTitle) async {
    try {
      if (selectedImage != null) {
        final fileName = 'libro/$libroTitle-${DateTime.now()}.png';
        final firebaseStorageReference =
            FirebaseStorage.instance.ref().child(fileName);

        await firebaseStorageReference.putFile(selectedImage!);
        final downloadUrl = await firebaseStorageReference.getDownloadURL();

        return downloadUrl;
      } else {
        return null;
      }
    } catch (error) {
      print("Error uploading image: $error");
      return null;
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } else {}
  }

  String?
      selectedFormato; // Debes definir esta variable para almacenar el rol seleccionado
  List<String> formatos = [
    'online',
    'fisico',
  ]; // Definir la lista de roles
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Libro'),
      ),
      body: BounceInRight(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SlideInUp(
            child: ListView(
              children: [
                TextFormField(
                  controller: tituloController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                    hintText: 'Titulo del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: autorController,
                  decoration: InputDecoration(
                    labelText: 'Autor',
                    hintText: 'Autor del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: isbnController,
                  decoration: InputDecoration(
                    labelText: 'Codigo',
                    hintText: 'Codigo del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                    hintText: 'Descripcion del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: disponibilidadController,
                  decoration: InputDecoration(
                    labelText: 'Disponibilidad',
                    hintText: 'Disponibilidad del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),
               DropdownButtonFormField<String>(
                  value: selectedFormato,
                  onChanged: (String? newValue) {
                    // Aquí puedes manejar el cambio de valor seleccionado
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
                    hintText: 'Selecciona un Formato para el libro',
                    icon: Icon(Icons.category_outlined),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: estadoController,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    hintText: 'Estado del libro',
                    icon: Icon(CupertinoIcons.book_solid),
                  ),
                ),
                SizedBox(height: 16.0),

             DropdownButton<String>(
  value: selectedCategoria,
  items: [
    DropdownMenuItem<String>(
      value: '',
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
      selectedCategoria = value!;
    });
  },
),


                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Seleccionar Imagen'),
                ),
                if (selectedImage != null) Image.file(selectedImage!),
                SizedBox(height: 32.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                  onPressed: () async {
    final downloadUrl = await _uploadImage(tituloController.text.trim());
    if (selectedCategoria != null) {
      final categoriaId = int.tryParse(selectedCategoria!);
      if (categoriaId != null) {
        final categoriaSeleccionada = {
          'id': categoriaId,
        };

        libroController.CrearLibro(
          tituloController.text.trim(),
          autorController.text.trim(),
          isbnController.text.trim(),
          descripcionController.text.trim(),
          disponibilidadController.text.trim(),
          selectedFormato ?? "", // Rol seleccionado
        //  formatoController.text.trim(),
          estadoController.text.trim(),
          // categoriaSeleccionada,
          downloadUrl ?? '',
          categoriaSeleccionada,
        );
        _navigateList(context);
      } else {
        print("Error: No se pudo convertir 'selectedCategoria' a entero.");
      }
    } else {
      print("Error: 'selectedCategoria' es null");
    }
  },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                50), // Agrega un BorderRadius de 10
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'CREAR',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                    width:
                        16), // Agrega un espacio entre el texto y el botón "Cancelar"
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/category');
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.red, // Color de fondo para el botón "Cancelar"
                    ),
                    child: Text(
                      "Cancelar",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
