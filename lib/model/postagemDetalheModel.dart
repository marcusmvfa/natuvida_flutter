class PostagemDetalheModel {
  final String texto;
  final bool flPergunta;
  final bool respostaText;
  String video;
  final String img;
  final String title;
  final List multipla;
  
  PostagemDetalheModel({this.texto, this.flPergunta, this.respostaText, this.video, this.img, this.title, this.multipla});

  factory PostagemDetalheModel.fromJson(Map<String, dynamic> json) {
    return new PostagemDetalheModel(
      texto: json['texto'] as String,
      flPergunta: json['flPergunta'] as bool,
      respostaText: json['respostaText'] as bool,
      video: json['video'] as String,
      img: json['img'] as String,
      title: json['title'] as String,
      multipla: json['multiplas'] as List
    );
  }
}