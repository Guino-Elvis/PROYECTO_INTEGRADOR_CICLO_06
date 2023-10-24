import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/service/authService/ApiService.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class MyDrawer2 extends StatefulWidget {
  final String accountName;

  MyDrawer2({required this.accountName});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer2> {
  String accountEmail = ""; // Correo electrónico del usuario
  String accountName = ""; // Nombre del usuario
  String accountFoto = ""; // Nombre del usuario

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  // Future<void> loadUserProfile() async {
    
  //   final profileData = await ApiService.getUserProfilee();
  //   if (profileData.isNotEmpty) {
  //     setState(() {
  //       accountName = profileData["name"] ?? "";
  //       accountEmail = profileData["email"] ?? "";
  //       accountFoto = profileData["foto"] ?? "";
  //     });
  //   }
  // }

  Future<void> loadUserProfile() async {
    final loginDetails = await ShareApiTokenService.loginDetails();

    if (loginDetails != null) {
      setState(() {
        accountName = loginDetails.user?.name ?? "";
        accountEmail = loginDetails.user?.email ?? "";
        accountFoto = loginDetails.user?.foto ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Container(
         color: Colors.white, // Cambia el color de fondo del Drawer
  
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  // Ajusta la altura a tu preferencia
                  height: 160,
                  width: 420,
                  // Ancho adaptable para adaptarse al contenedor
                  child: Image.asset(
                    "assets/fondologin2.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                UserAccountsDrawerHeader(
                  accountName: Text(
                      accountName.isEmpty ? widget.accountName : accountName),
                  accountEmail: Text(accountEmail),
                  currentAccountPicture: accountFoto.isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Color del borde
                              width: 2.0, // Ancho del borde
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Color del borde
                              width: 3.0, // Ancho del borde
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(accountFoto),
                          ),
                        ),
                  decoration: BoxDecoration(
                    color: HexColor("#0e1b4d").withOpacity(0.8),
                  ),
                  margin: EdgeInsets.all(0),
                  // Elimina el margen predeterminado para evitar superposiciones
                ),
              ],
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
            ),
            ListTile(
              title: Text('Category'),
              leading: Icon(Icons.category),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/category', (route) => false);
              },
            ),
            ListTile(
              title: Text('Alumnos'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/alumno', (route) => false);
              },
            ),
            ListTile(
              title: Text('Usuarios'),
              leading: Icon(Icons.person_4_rounded),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/usuario', (route) => false);
              },
            ),
            ListTile(
              title: Text('Libros'),
              leading: Icon(Icons.book_online),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/librohome', (route) => false);
              },
            ),
           
            Divider(),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                ShareApiTokenService.logout(context);
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
