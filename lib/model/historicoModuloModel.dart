class HistoricoModuloModel {
  String? id;
  String? idUsuario;
  String? idModulo;
  String? situacao;

  HistoricoModuloModel({this.id, this.idUsuario, this.idModulo, this.situacao});

  factory HistoricoModuloModel.fromJson(Map<String, dynamic> json) {
    return new HistoricoModuloModel(
        id: json['_id'],
        idUsuario: json['idUsuario'],
        idModulo: json['idPostagem'],
        situacao: json['situacao']);
  }
}
