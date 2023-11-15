class LibroModel {
  int? id;
  String? titulo;
  String? autor;
  String? isbn;
  String? descripcion;
  String? disponibilidad;
  String? formato;
  String? estado;
  String? foto;
  Categorialib? categorialib;
  String? createdAt;
  String? updatedAt;

  LibroModel(
      {this.id,
      this.titulo,
      this.autor,
      this.isbn,
      this.descripcion,
      this.disponibilidad,
      this.formato,
      this.estado,
      this.foto,
      this.categorialib,
      this.createdAt,
      this.updatedAt});

  LibroModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    autor = json['autor'];
    isbn = json['isbn'];
    descripcion = json['descripcion'];
    disponibilidad = json['disponibilidad'];
    formato = json['formato'];
    estado = json['estado'];
    foto = json['foto'];
    categorialib = json['categorialib'] != null
        ? new Categorialib.fromJson(json['categorialib'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['autor'] = this.autor;
    data['isbn'] = this.isbn;
    data['descripcion'] = this.descripcion;
    data['disponibilidad'] = this.disponibilidad;
    data['formato'] = this.formato;
    data['estado'] = this.estado;
    data['foto'] = this.foto;
    if (this.categorialib != null) {
      data['categorialib'] = this.categorialib!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Categorialib {
  int? id;
  Null? titulo;
  Null? descripcion;
  Null? foto;
  String? createdAt;
  String? updatedAt;

  Categorialib(
      {this.id,
      this.titulo,
      this.descripcion,
      this.foto,
      this.createdAt,
      this.updatedAt});

  Categorialib.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['foto'] = this.foto;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
