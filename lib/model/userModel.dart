class UserModel {
  final String id;
  final String login;
  String nome;
  String email;
  String telefone;
  String dataAlteracao;
  
  UserModel({ this.id, this.login, this.nome, this.email, this.telefone, this.dataAlteracao});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return new UserModel(
      id: json['_id'] as String,
      login: json['login'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['fone'] as String,
      dataAlteracao: json['dataAlteracao'] as String
    );
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