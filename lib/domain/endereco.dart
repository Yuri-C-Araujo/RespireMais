class Endereco {
  // Os nomes das variáveis continuam os mesmos
  // para que o seu 'cadastro.dart' não quebre
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

  // A MUDANÇA ESTÁ AQUI
  // Atualizamos o 'fromJson' para os campos da API ViaCEP
  Endereco.fromJson(Map<String, dynamic> json) {
    cep = json['cep'] ?? '';
    rua = json['logradouro'] ?? ''; // 'logradouro' é o nome da rua na ViaCEP
    bairro = json['bairro'] ?? '';
    cidade = json['localidade'] ?? ''; // 'localidade' é a cidade na ViaCEP
    estado = json['uf'] ?? ''; // 'uf' é o estado na ViaCEP
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['logradouro'] = this.rua; // Poderia ser 'rua' aqui, mas mantemos o padrão
    data['bairro'] = this.bairro;
    data['localidade'] = this.cidade;
    data['uf'] = this.estado;
    return data;
  }
}