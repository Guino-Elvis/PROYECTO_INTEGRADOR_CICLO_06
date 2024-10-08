import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/component/Actualizar.dart';
import 'package:flutter_application_1/src/config/theme.dart';
import 'package:flutter_application_1/src/pages/cruds/alumno/AlumnoList.dart';
import 'package:flutter_application_1/src/pages/auth/LoginPage.dart';
import 'package:flutter_application_1/src/pages/auth/RegisterPage.dart';
import 'package:flutter_application_1/src/pages/cruds/libro/libro_list.dart';
import 'package:flutter_application_1/src/pages/cruds/reserva_lib/Reserva_list.dart';
import 'package:flutter_application_1/src/pages/escolar/widgets/ui/home_screen_escolar.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Categories_libro.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Detalle.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Inicio.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Favoritos.dart';
import 'package:flutter_application_1/src/pages/cruds/usuario/UsuarioList.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Libro_fisico.dart';
import 'package:flutter_application_1/src/pages/libros/pages/ui/Reserva_libro.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter_application_1/src/pages/cruds/categoria/CategoriaList.dart';
import 'package:flutter_application_1/src/sql/ApiCacheDatabase.dart';
import 'package:flutter_application_1/src/view/AdminHomePage.dart';
import 'package:flutter_application_1/src/view/HomePage.dart';
import 'package:flutter_application_1/src/view/UserHomePage.dart';
import 'package:provider/provider.dart';


Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize sqflite
  final apiCacheDatabase = ApiCacheDatabase();
  await apiCacheDatabase.open();

  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
        apiKey: "AIzaSyCVq_E2pZ5FD8Q6RWSKEmnjmZ8WVrh7PkA",
        authDomain: "proyectointegrador-e2212.firebaseapp.com",
        projectId: "proyectointegrador-e2212",
        storageBucket: "proyectointegrador-e2212.appspot.com",
        messagingSenderId: "4455056114",
        appId: "1:4455056114:web:aa0af31fa1f65548e9c66b",
        measurementId: "G-MDZRF01NHQ"),
  );
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  bool _result = await ShareApiTokenService.isLoggedIn();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Actualizar>(create: (_) => Actualizar()),
        ChangeNotifierProvider.value(
            value: themeProvider), // Proporciona la instancia de ThemeProvider
        // Otros providers si los tienes
      ],
      // ignore: prefer_const_constructors
      child: MyApp(),
    ),
  );
  // MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Ocultar los botones de navegación y hacer que la barra de notificaciones sea transparente
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,overlays: []);
    // Ocultar los botones de navegación después de 1 o 2 segundos
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
    return MaterialApp(
      title: ' APIS APLICACION',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
        //CRUDS
        '/category': (context) => const CategoriaList(),
        '/alumno': (context) => const AlumnoList(),
        '/usuario': (context) => const UsuarioList(),
        '/libro_crud': (context) => const LibroList(),
        '/reserva_crud': (context) => const ReservasList(),
         //CRUDS
        '/admin_home': (context) => AdminHomePage(),
        '/user_home': (context) => UserHomePage(),
        //LIBRO RUTAS
        '/librohome': (context) => Inicio(),
        '/librocategory': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return CategoriView(categoryId: args['categoryId']);
          },
        '/librofisico': (context) => const LibroFisico(),
        '/reserbalibro': (context) => const ReservaLibro(libro: null,),
        '/favoritos': (context) => const Favoritos(),
        '/detalle': (context) => const Detalle(libro: null,),
        //COLEGIO RUTAS 
        '/colegiohome': (context) => HomeScreenEscolar(),
      },
      // home: CategoriaList(),
    );
  }
}
