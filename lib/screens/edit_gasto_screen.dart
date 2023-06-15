import 'package:flutter/material.dart';
import 'package:meu_orcamento/components/carregamento.dart';
import 'package:meu_orcamento/data/gasto_dao.dart';
import 'package:meu_orcamento/helpers/is_less_than_1.dart';
import 'package:meu_orcamento/model/gasto.dart';
class EditScreen extends StatefulWidget {
  final int id;
  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _chaveForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.edit),
              ),
              Text(
                "Editar Gasto",
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: GastoDao().getByID(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Gasto? gasto = snapshot.data;
              if (snapshot.hasData && gasto != null) {
                final TextEditingController valorUserController =
                    TextEditingController(text: gasto.valor.toString());
                return Form(
                  key: _chaveForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        gasto.nome,
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              validator: (value) {
                                if (isLessThan1(value)) {
                                  return 'O valor deve ser maior que 1!';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              controller: valorUserController,
                              cursorColor: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      adicionar10(valorUserController);
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        remover10(valorUserController);
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 50,
                          width: 130,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_chaveForm.currentState!.validate()) {
                                  GastoDao()
                                      .edit(
                                          Gasto(
                                              gasto.nome,
                                              double.parse(
                                                  valorUserController.text)),
                                          widget.id)
                                      .then((value) {
                                    if (value == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                            child: Text(
                                              "Editado com sucesso",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Center(
                                            child: Text(
                                              "Não foi possivel editar",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
                              },
                              child: const Text("Salvar")))
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('Sem informação'),
                );
              }
            } else {
              return const Carregamento();
            }
          },
        ),
      ),
    );
  }
}

void adicionar10(TextEditingController valorUserController) {
  final double valor = double.parse(valorUserController.text);
  final double soma = valor + 10;

  valorUserController.text = soma.toString();
}

void remover10(TextEditingController valorUserController) {
  final double valor = double.parse(valorUserController.text);
  final double subtracao = valor - 10;

  valorUserController.text = subtracao.toString();
}
