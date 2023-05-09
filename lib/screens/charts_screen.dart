import 'package:flutter/material.dart';
import 'package:orcamento_app/components/card_gasto.dart';
import 'package:orcamento_app/data/gasto_dao.dart';
import 'package:orcamento_app/helpers/pie_chart.dart';

import '../model/chart_data.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Future<List<dynamic>> _cardAndTotal() async {
    final List<CardGasto> gastos = await GastoDao().getAll();
    final double valorTotal = await GastoDao().getValorTotalGastos();
    return [gastos, valorTotal];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.pie_chart_outline),
            ),
            Text("Gráfico"),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder(
            future: _cardAndTotal(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: Text(
                    "Carregando...",
                    style: TextStyle(
                      color: Color.fromARGB(255, 148, 148, 148),
                      fontSize: 15,
                    ),
                  ),
                );
              } else {
                List<CardGasto>? values = snapshot.data?[0];
                late List<ChartData> data = [];
                if (snapshot.hasData && values != null) {
                  if (values.isNotEmpty) {
                    for (var element in values) {
                      data.add(
                        ChartData(element.cardNome, element.cardValor,
                            "${((element.cardValor * 100) / snapshot.data![1]).toStringAsFixed(1)}%"),
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PieChart(nome: "Item", data: data),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              "images/chart.gif",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "Crie um gasto",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 148, 148, 148),
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            "images/chart.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "Crie um gasto",
                            style: TextStyle(
                                color: Color.fromARGB(255, 148, 148, 148),
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}
