import 'package:natuvida_flutter/model/postagemDetalheModel.dart';

class PostagemModel {
  final String id;
  final String title;
  final String imgPostagem;
  final int order;
  final String modulo;
  final String quiz;
  String situacao;
  double percConclusao;
  bool finalizada;
  List<PostagemDetalheModel> detalhesPostagens;
  
  PostagemModel({this.id,
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
      id: json['_id'] as String,
      title: json['title'] as String,
      imgPostagem: json['imgPostagem'] as String,
      order: json['order'] as int,
      modulo: json['modulo'] as String,
      quiz: json['quiz'] as String,
      situacao: json['situacao'] as String,
      percConclusao: json['percConclusao'] as double,
      detalhesPostagens: json['detalhesPostagens'] as List<PostagemDetalheModel>,
    );
  }
}