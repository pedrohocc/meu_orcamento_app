import 'package:flutter/material.dart';
import 'package:orcamento_app/data/orcamento_dao.dart';
import 'package:orcamento_app/helpers/validator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _chaveForm = GlobalKey<FormState>();

  TextEditingController valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações"), centerTitle: true),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo2.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _chaveForm,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        decoration:
                            const InputDecoration(labelText: "Valor inicial"),
                        validator: (value) {
                          if (isNullOrEmpty(value)) {
                            return "Insira um valor";
                          } else {
                            return null;
                          }
                        },
                        controller: valorController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: 130,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_chaveForm.currentState!.validate()) {
                              OrcamentoDao()
                                  .save(
                                double.parse(valorController.text),
                              )
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Center(child: Text("Valor Salvo!")),
                                  ),
                                );
                                Navigator.pop(context, value);
                              });
                            }
                          },
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
