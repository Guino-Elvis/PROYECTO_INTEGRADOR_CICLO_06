import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Actualizar.dart';
import 'package:flutter_application_1/src/pages/alumno/AlumnoList.dart';
import 'package:flutter_application_1/src/pages/auth/LoginPage.dart';
import 'package:flutter_application_1/src/pages/auth/RegisterPage.dart';
import 'package:flutter_application_1/src/pages/usuario/UsuarioList.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter_application_1/src/pages/categoria/CategoriaList.dart';
import 'package:flutter_application_1/src/sql/ApiCacheDatabase.dart';
import 'package:flutter_application_1/src/view/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

// void main() {
//   runApp(const MyApp());
// }


Widget _defaultHome =  const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // Initialize sqflite
final apiCacheDatabase = ApiCacheDatabase();
  await apiCacheDatabase.open();

  await Firebase.initializeApp(
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
  bool _result = await ShareApiTokenService.isLoggedIn();
  if(_result){
    _defaultHome = HomePage();
  }
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider<Actualizar>(create: (_) => Actualizar()),
        // Otros providers si los tienes
      ],
      child: MyApp(),
    ),
     );
    // MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
        '/home': (context) =>  HomePage(),
        '/category': (context) => const CategoriaList(),
        '/alumno': (context) => const AlumnoList(),
        '/usuario': (context) => const UsuarioList(),
        },
      // home: CategoriaList(),
    );
  }
}
