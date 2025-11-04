class Endereco {
  late String cep;
  late String rua;
  late String bairro;
  late String cidade;
  late String estado;

  Endereco({
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.estado,
  });

  Endereco.fromJson(Map<String, dynamic> json) {
    cep = json['cep'] ?? '';
    rua = json['logradouro'] ?? '';
    bairro = json['bairro'] ?? '';
    cidade = json['localidade'] ?? '';
    estado = json['uf'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['logradouro'] = this.rua;
    data['bairro'] = this.bairro;
    data['localidade'] = this.cidade;
    data['uf'] = this.estado;
    return data;
  }
}