class Relatorio {
  int? id;
  late String descricao;
  late double niveldor;
  late String? fadiga;
  late bool nausea;
  late bool faltaDeAr;
  late bool tosse;
  late String data;

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

  Relatorio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    niveldor = json['niveldor'];
    fadiga = json['fadiga'];
    nausea = json['nausea'] == 1;
    faltaDeAr = json['faltaDeAr'] == 1;
    tosse = json['tosse'] == 1;
    data = json['data'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['niveldor'] = this.niveldor;
    data['fadiga'] = this.fadiga;
    data['nausea'] = this.nausea == true ? 1 : 0;
    data['faltaDeAr'] = this.faltaDeAr == true ? 1 : 0;
    data['tosse'] = this.tosse == true ? 1 : 0;
    data['data'] = this.data;
    return data;
  }
}
