import 'package:hive_flutter/hive_flutter.dart';
import 'package:orcamento_app/components/card_gasto.dart';
import 'package:orcamento_app/model/gasto.dart';

class GastoDao {
  Future<bool> save(Gasto gasto) async {
    try {
      Map mapGasto = {
        "nome": gasto.nome,
        "valor": gasto.valor,
      };

      Box box = await Hive.openBox("Gastos");

      box.add(mapGasto);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> edit(Gasto gasto, int id) async {
    try {
      Box box = await Hive.openBox("Gastos");
      box.putAt(id, {"nome": gasto.nome, "valor": gasto.valor});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<double> getValorTotalGastos() async {
    double sum = 0;
    Box box = await Hive.openBox("Gastos");

    for (var element in box.keys) {
      dynamic card = box.get(element);
      double valor = card['valor'];
      sum += valor;
    }

    return sum;
  }

  Future<List<CardGasto>> getAll() async {
    List<Gasto> gastos = [];
    Box box = await Hive.openBox("Gastos");

    for (var element in box.keys) {
      dynamic card = box.get(element);
      String nome = card['nome'];
      double valor = card['valor'];

      Gasto gasto = Gasto(nome.toUpperCase(), valor);

      gastos.add(gasto);
    }
    return toCardGasto(gastos);
  }

  Future<Gasto> getByID(int index) async {
    final Box box = await Hive.openBox("Gastos");
    final dynamic item = box.getAt(index);
    final String nomeGasto = item['nome'];
    final double valorGasto = item['valor'];
    final Gasto gasto = Gasto(nomeGasto.toUpperCase(), valorGasto);
    return gasto;
  }

  void deleteAll() async {
    Box box = await Hive.openBox("Gastos");
    for (var element in box.keys) {
      box.delete(element);
    }
  }

  void deleteSingle(int i) async {
    Box box = await Hive.openBox("Gastos");
    box.deleteAt(i);
  }

  List<CardGasto> toCardGasto(List<Gasto> gastos) {
    List<CardGasto> cardList = [];

    for (var element in gastos) {
      String nome = element.nome;
      double valor = element.valor;

      cardList.add(
        CardGasto(cardNome: nome, cardValor: valor),
      );
    }
    return cardList;
  }
}
