class roleauth {
  int? id;
  String? foto;
  String? role;
  String? name;
  String? email;
  String? password;
  Null? confirmPassword;
  String? apellidoP;
  String? apellidoM;
  String? dni;
  String? codigo;
  String? createdAt;
  String? updatedAt;

  roleauth(
      {this.id,
      this.foto,
      this.role,
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.apellidoP,
      this.apellidoM,
      this.dni,
      this.codigo,
      this.createdAt,
      this.updatedAt});

  roleauth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foto = json['foto'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    apellidoP = json['apellido_p'];
    apellidoM = json['apellido_m'];
    dni = json['dni'];
    codigo = json['codigo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto'] = this.foto;
    data['role'] = this.role;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['apellido_p'] = this.apellidoP;
    data['apellido_m'] = this.apellidoM;
    data['dni'] = this.dni;
    data['codigo'] = this.codigo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}