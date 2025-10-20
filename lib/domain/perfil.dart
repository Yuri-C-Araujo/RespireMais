class perfil {
  late String nome;
  late String diagnostico;
  late String senha;
  late String? fotoUrl;

  perfil({
    required this.nome,
    required this.diagnostico,
    required this.senha,
    this.fotoUrl,
  });

  perfil.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    diagnostico = json['diagnostico'];
    senha = json['senha'];
    fotoUrl = json['fotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nome'] = this.nome;
    data['diagnostico'] = this.diagnostico;
    data['senha'] = this.senha;
    data['fotoUrl'] = this.fotoUrl;
    return data;
  }
}
