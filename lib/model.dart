class Medicamento {
  int? id;
  String nome;
  String horario;
  String urlImagem;

  Medicamento({this.id, required this.nome, required this.horario, required this.urlImagem});

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'horario': horario,
    'urlImagem': urlImagem,
  };

  factory Medicamento.fromJson(Map<String, dynamic> json) => Medicamento(
    id: json['id'],
    nome: json['nome'],
    horario: json['horario'],
    urlImagem: json['urlImagem'],
  );
}
