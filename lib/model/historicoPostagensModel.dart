class HistoricoPostagensModel {
  String? id;
  String? idUsuario;
  String? idPostagem;
  String? situacao;
  String? percConclusao;

  HistoricoPostagensModel(
      {this.id, this.idUsuario, this.idPostagem, this.situacao, this.percConclusao});

  factory HistoricoPostagensModel.fromJson(Map<String, dynamic> json) {
    return new HistoricoPostagensModel(
        id: json['_id'],
        idUsuario: json['idUsuario'],
        idPostagem: json['idPostagem'],
        situacao: json['situacao'],
        percConclusao: json['percConclusao']);
  }
}
