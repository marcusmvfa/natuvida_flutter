class HistoricoPostagensModel {
  String id;
  String idUsuario;
  String idPostagem;
  String situacao;
  String percConclusao;

  HistoricoPostagensModel({this.id, 
  this.idUsuario, 
  this.idPostagem, 
  this.situacao, 
  this.percConclusao});

  factory HistoricoPostagensModel.fromJson(Map<String, dynamic> json) {
    return new HistoricoPostagensModel(
      id: json['_id'] as String,
      idUsuario: json['idUsuario'] as String,
      idPostagem: json['idPostagem'] as String,
      situacao: json['situacao'] as String,
      percConclusao: json['percConclusao'] as String    );
  }
}