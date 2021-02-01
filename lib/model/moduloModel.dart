class ModuloModel {
  String id;
  String title;
  String subTitle;
  String dataInclusao;
  String quiz;
  String situacao;

  ModuloModel({this.id, 
  this.title, 
  this.subTitle, 
  this.dataInclusao, 
  this.quiz, 
  this.situacao});

  factory ModuloModel.fromJson(Map<String, dynamic> json) {
    return new ModuloModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      dataInclusao: json['dataInclusao'] as String,
      quiz: json['quiz'] as String,
      situacao: json['situacao'] as String
    );
  }
}