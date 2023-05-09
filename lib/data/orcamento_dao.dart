import 'package:hive_flutter/hive_flutter.dart';

class OrcamentoDao {
  Future<bool> save(double valor) async {
    try {
      Box box = await Hive.openBox("Orcamento");
      box.put("valor_inicial", valor);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<double> getValorOrcamento() async {
    Box box = await Hive.openBox("Orcamento");
    double valor = box.get("valor_inicial");
    return valor;
  }
}
