class DadosUsu{
  late String nome;
  late String email;
  late String senha;
  late String dataNasc;
  late String oqSente;

  late String cep;
  late String rua;
  late String bairro;
  late String cidade;
  late String estado;

  DadosUsu({
    required this.nome,
    required this.email,
    required this.senha,
    required this.dataNasc,
    required this.oqSente,

    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
});

  String get nomeMaiusculo => nome.split(' ')[0].toUpperCase();

  DadosUsu.fromJson(Map<String, dynamic> json){
    nome = json['nome'];
    email = json['email'];
    senha = json['senha'];
    dataNasc = json['dataNasc'];
    oqSente = json['oqSente'];

    cep = json['cep'] ?? '';
    rua = json['rua'] ?? '';
    bairro = json['bairro'] ?? '';
    cidade = json['cidade'] ?? '';
    estado = json['estado'] ?? '';
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['dataNasc'] = this.dataNasc;
    data['oqSente'] = this.oqSente;

    data['cep'] = this.cep;
    data['rua'] = this.rua;
    data['bairro'] = this.bairro;
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    return data;
  }
}