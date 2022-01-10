class UserModel {
  String? id;
  String? login;
  String? nome;
  String? email;
  String? telefone;
  String? dataAlteracao;

  UserModel({this.id, this.login, this.nome, this.email, this.telefone, this.dataAlteracao});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return new UserModel(
        id: json['_id'],
        login: json['login'],
        nome: json['nome'],
        email: json['email'],
        telefone: json['fone'],
        dataAlteracao: json['dataAlteracao']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['dataAlteracao'] = this.dataAlteracao;
    return data;
  }
}
