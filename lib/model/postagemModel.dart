import 'package:natuvida_flutter/model/postagemDetalheModel.dart';

class PostagemModel {
  String? id;
  String? title;
  String? imgPostagem;
  int? order;
  String? modulo;
  String? quiz;
  String? situacao;
  double? percConclusao;
  bool? finalizada;
  List<PostagemDetalheModel>? detalhesPostagens;

  PostagemModel(
      {this.id,
      this.title,
      this.imgPostagem,
      this.order,
      this.detalhesPostagens,
      this.modulo,
      this.quiz,
      this.situacao,
      this.percConclusao});

  factory PostagemModel.fromJson(Map<String, dynamic> json) {
    return new PostagemModel(
      id: json['_id'],
      title: json['title'],
      imgPostagem: json['imgPostagem'],
      order: json['order'] as int,
      modulo: json['modulo'],
      quiz: json['quiz'],
      situacao: json['situacao'],
      percConclusao: json['percConclusao'],
      detalhesPostagens: json['detalhesPostagens'],
    );
  }
}
