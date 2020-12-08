import 'package:natuvida_flutter/model/postagemDetalheModel.dart';

class PostagemModel {
  final String id;
  final String title;
  final String imgPostagem;
  List<PostagemDetalheModel> detalhesPostagens;
  
  PostagemModel({this.id, this.title, this.imgPostagem, this.detalhesPostagens});

  factory PostagemModel.fromJson(Map<String, dynamic> json) {
    return new PostagemModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      imgPostagem: json['imgPostagem'] as String,
      detalhesPostagens: json['detalhesPostagens'] as List<PostagemDetalheModel>,
    );
  }
}