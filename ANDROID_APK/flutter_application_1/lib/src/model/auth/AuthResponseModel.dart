import 'dart:convert';

AuthResponseModel authResponseJson(String str) =>
AuthResponseModel.fromJson(json.decode(str));
class AuthResponseModel {
  AuthResponseModel({
    // required this.email,
    // required this.password,
     required this.token,
  });
  // late final  String? email;
  // late final  String? password;
   late final  String? token;
 

  // AuthModel.dart({this.email, this.password});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // email = json['email'];
    // password = json['password'];
      token = json['token'];
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    final _data = <String, dynamic>{};
    // _data['email'] = this.email;
    // _data['password'] = this.password;
     _data['token'] = this.token;
    return _data;
  }
}
