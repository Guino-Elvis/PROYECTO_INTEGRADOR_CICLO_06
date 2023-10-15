import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/component/Sidebar.dart';
import 'package:flutter_application_1/src/model/auth/AuthResponseModel.dart';
import 'package:flutter_application_1/src/pages/auth/UserProfile.dart';
import 'package:flutter_application_1/src/service/authService/ApiService.dart';
import 'package:flutter_application_1/src/service/authService/ShareApiTokenService.dart';
import 'package:flutter_application_1/src/view/CategoriaList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Home Page'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ShareApiTokenService.logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(accountName: "Usuario"),
      // drawer: MyDrawer(accountName: "Usuario"),
      // drawer: MyDrawer(accountName: "Usuario", accountEmail: "usuario@example.com"),
      backgroundColor: Colors.grey[200],
      body: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder<List<String>>(
      future: ApiService.getUserProfile(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final emailList = snapshot.data!;

            return ListView.builder(
              itemCount: emailList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(emailList[index], style: TextStyle(fontSize: 16)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
