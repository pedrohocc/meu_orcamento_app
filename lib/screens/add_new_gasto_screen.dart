import 'package:flutter/material.dart';
import '../helpers/validator.dart';
import '../data/gasto_dao.dart';
import '../model/gasto.dart';

class AddNewGastoScrenn extends StatefulWidget {
  const AddNewGastoScrenn({super.key});

  @override
  State<AddNewGastoScrenn> createState() => _AddNewGastoScrennState();
}

class _AddNewGastoScrennState extends State<AddNewGastoScrenn> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  final _chaveForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADICIONAR GASTO"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/fundo2.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _chaveForm,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              validator: (value) {
                                if (isNullOrEmpty(value)) {
                                  return "Insira um nome";
                                }
                                return null;
                              },
                              controller: nomeController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: ("Nome"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              validator: (value) {
                                if (isNullOrEmpty(value)) {
                                  return "Insira um valor";
                                } else {
                                  if(double.parse(value!) <= 0) {
                                    return "Insira um valor maior que zero";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              controller: valorController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: ("Valor"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_chaveForm.currentState!.validate()) {
                                String nome = nomeController.text;
                                double valor = double.parse(valorController.text);
                                Gasto gasto = Gasto(nome, valor);
                                GastoDao()
                                    .save(gasto)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                        child: Text(
                                          "Gasto adicionado com sucesso",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  );
                                  Navigator.pop(context, value);
                                });
                              }
                            },
                            child: const Text(
                              "Adicionar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
