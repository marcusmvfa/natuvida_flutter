class UserModel {
  final String id;
  final String login;
  final String nome;
  final String email;
  final String telefone;
  
  UserModel({ this.id, this.login, this.nome, this.email, this.telefone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return new UserModel(
      id: json['_id'] as String,
      login: json['login'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
    );
  }
}