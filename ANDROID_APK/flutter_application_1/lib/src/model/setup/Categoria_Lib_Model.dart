class CategoriaLibModel {
  int? id;
  String? titulo;
  String? descripcion;
  String? foto;


  CategoriaLibModel(
      {this.id,
      this.titulo,
      this.descripcion,
      this.foto,
     });

  CategoriaLibModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    foto = json['foto'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['foto'] = this.foto;

    return data;
  }
}
