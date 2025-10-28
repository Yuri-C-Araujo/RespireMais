class PerfilModel {
  final int id;
  final String nome;
  final String senha;
  final String diagnostico;
  final String urlImagemOriginal;

  PerfilModel({
    required this.id,
    required this.nome,
    required this.senha,
    required this.diagnostico,
    required this.urlImagemOriginal,
  });

  factory PerfilModel.fromJson(Map<String, dynamic> json) {
    return PerfilModel(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      senha: json['senha'] ?? '',
      diagnostico: json['diagnostico'] ?? '',
      urlImagemOriginal: json['fotoUrl'] ?? '',
    );
  }
}
