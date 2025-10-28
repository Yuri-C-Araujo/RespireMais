class Informacoes{
  late String datas;
  late String dor;
  late String fadiga;
  late String efeitoColateral;

  Informacoes ({
    required this.datas,
    required this.dor,
    required this.fadiga,
    required this.efeitoColateral,
  });

  Informacoes.fromJson(Map<String, dynamic> json){
    datas = json['datas'] ?? '';
    dor = json['dor'] ?? '';
    fadiga = json['fadiga'] ?? '';
    efeitoColateral = json['efeitoColateral'] ?? '';
  }

  Map<String, dynamic> toJson(){

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['datas'] = this.datas;
    data['dor'] = this.dor;
    data['fadiga'] = this.fadiga;
    data['efeitoColateral'] = this.efeitoColateral;
    return data;
    }
}