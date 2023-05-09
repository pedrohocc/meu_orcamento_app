import 'package:flutter/material.dart';
import 'package:orcamento_app/data/gasto_dao.dart';
import 'package:orcamento_app/data/orcamento_dao.dart';
import 'package:orcamento_app/screens/settings_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    _saldo = saldo();
    super.initState();
  }

  Future<List<String>>? _saldo;

  Future<List<String>> saldo() async {
    double valorInical = await OrcamentoDao().getValorOrcamento();
    double valorGastos = await GastoDao().getValorTotalGastos();
    double restante = valorInical - valorGastos;
    return [valorInical.toStringAsFixed(2), restante.toStringAsFixed(2)];
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
              child: Icon(Icons.wallet),
            ),
            Text("Carteira"),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/fundo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
          future: _saldo,
          builder: (context, snapshot) {
            List<String>? values = snapshot.data;
            if (snapshot.connectionState != ConnectionState.done) {
              return Container();
            } else {
              if (snapshot.hasData && values != null) {
                if (values.isNotEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 320,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 61, 133, 164),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(50, 0, 0, 0),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(0, 0))
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "INICIAL: R\$ ${snapshot.data![0]}",
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "ATUAL: R\$ ${snapshot.data![1]}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 50,
                          width: 130,
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(50, 0, 0, 0),
                                    spreadRadius: 5,
                                    blurRadius: 10,
                                    offset: Offset(0, 0))
                              ],
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingsScreen(),
                                    ),
                                  ).then((value) {
                                    if (value == true) {
                                      setState(() {
                                        _saldo = saldo();
                                      });
                                    }
                                  });
                                },
                                child: const Text(
                                  "Alterar Valor",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.asset(
                            "images/settings.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 50,
                            width: 130,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(50, 0, 0, 0),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SettingsScreen(),
                                      ),
                                    ).then((value) {
                                      if (value == true) {
                                        setState(() {
                                          _saldo = saldo();
                                        });
                                      }
                                    });
                                  },
                                  child: const Text("Definir valor")),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          "images/settings.gif",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: 50,
                        width: 130,
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0))
                            ],
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    setState(() {
                                      _saldo = saldo();
                                    });
                                  }
                                });
                              },
                              child: const Text("Definir valor")),
                        ),
                      ),
                    )
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
