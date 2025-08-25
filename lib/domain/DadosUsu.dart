class DadosUsu{
  late String nome;
  late String email;
  late String senha;
  late String dataNasc;
  late String oqSente;

  DadosUsu({
    required this.nome,
    required this.email,
    required this.senha,
    required this.dataNasc,
    required this.oqSente,
});

  DadosUsu.fromJson(Map<String, dynamic> json){
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    dataNasc = json['dataNasc'];
    oqSente = json['oqSente'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['dataNasc'] = this.dataNasc;
    data['oqSente'] = this.oqSente;
    return data;
  }
}