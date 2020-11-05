class PostagemModel {
  final String texto;
  final bool flPergunta;
  final bool respostaText;
  final String video;
  final String img;
  
  PostagemModel({this.texto, this.flPergunta, this.respostaText, this.video, this.img});

  factory PostagemModel.fromJson(Map<String, dynamic> json) {
    return new PostagemModel(
      texto: json['texto'] as String,
      flPergunta: json['flPergunta'] as bool,
      respostaText: json['respostaText'] as bool,
      video: json['video'] as String,
      img: json['img'] as String
    );
  }
}