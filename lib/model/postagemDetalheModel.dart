class PostagemDetalheModel {
  String? id;
  String? texto;
  bool? flPergunta;
  bool? respostaText;
  String? video;
  String? img;
  String? title;
  int? index;
  List? multipla;

  PostagemDetalheModel(
      {this.id,
      this.texto,
      this.flPergunta,
      this.respostaText,
      this.video,
      this.img,
      this.title,
      this.multipla});

  factory PostagemDetalheModel.fromJson(Map<String, dynamic> json) {
    return new PostagemDetalheModel(
        id: json['_id'],
        texto: json['texto'],
        flPergunta: json['flPergunta'],
        respostaText: json['respostaText'],
        video: json['video'],
        img: json['img'],
        title: json['title'],
        multipla: json['multiplas']);
  }
}
