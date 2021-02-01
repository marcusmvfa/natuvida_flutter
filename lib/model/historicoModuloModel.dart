class HistoricoModuloModel {
  String id;
  String idUsuario;
  String idModulo;
  String situacao;

  HistoricoModuloModel({this.id, 
  this.idUsuario, 
  this.idModulo, 
  this.situacao});

  factory HistoricoModuloModel.fromJson(Map<String, dynamic> json) {
    return new HistoricoModuloModel(
      id: json['_id'] as String,
      idUsuario: json['idUsuario'] as String,
      idModulo: json['idPostagem'] as String,
      situacao: json['situacao'] as String);
  }
}