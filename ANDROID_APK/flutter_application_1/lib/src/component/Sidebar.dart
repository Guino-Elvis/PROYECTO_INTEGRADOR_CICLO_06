import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/service/authService/ApiService.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';

class MyDrawer extends StatefulWidget {
  final String accountName;

  MyDrawer({required this.accountName});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String accountEmail = ""; // Correo electrónico del usuario
  String accountName = "";  // Nombre del usuario

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    final profileData = await ApiService.getUserProfilee();
    if (profileData.isNotEmpty) {
      setState(() {
        accountName = profileData.first["name"]!;
        accountEmail = profileData.first["email"]!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName.isEmpty ? widget.accountName : accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          ),
          ListTile(
            title: Text('Category'),
            leading: Icon(Icons.category),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/category', (route) => false);
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
    );
  }
}
