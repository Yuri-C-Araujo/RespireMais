class Relatorio {
  int? id;
  String descricao;
  double niveldor;
  String? fadiga;
  bool nausea;
  bool faltaDeAr;
  bool tosse;
  String data;

  Relatorio({
    this.id,
    required this.descricao,
    required this.niveldor,
    this.fadiga,
    this.nausea = false,
    this.faltaDeAr = false,
    this.tosse = false,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'niveldor': niveldor,
      'fadiga': fadiga,
      'nausea': nausea ? 1 : 0,
      'faltaDeAr': faltaDeAr ? 1 : 0,
      'tosse': tosse ? 1 : 0,
      'data': data,
    };
  }

  factory Relatorio.fromJson(Map<String, dynamic> json) {
    return Relatorio(
      id: json['id'],
      descricao: json['descricao'],
      niveldor: json['niveldor'],
      fadiga: json['fadiga'],
      nausea: json['nausea'] == 1,
      faltaDeAr: json['faltaDeAr'] == 1,
      tosse: json['tosse'] == 1,
      data: json['data'],
    );
  }
}
