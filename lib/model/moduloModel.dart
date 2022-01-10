class ModuloModel {
  String? id;
  String? title;
  String? subTitle;
  String? dataInclusao;
  String? quiz;
  String? situacao;

  ModuloModel({this.id, this.title, this.subTitle, this.dataInclusao, this.quiz, this.situacao});

  factory ModuloModel.fromJson(Map<String, dynamic> json) {
    return new ModuloModel(
        id: json['_id'],
        title: json['title'],
        subTitle: json['subTitle'],
        dataInclusao: json['dataInclusao'],
        quiz: json['quiz'],
        situacao: json['situacao']);
  }
}
