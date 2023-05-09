import 'package:flutter/material.dart';
import 'package:orcamento_app/data/gasto_dao.dart';
import 'package:orcamento_app/helpers/is_less_than_1.dart';

import '../model/gasto.dart';

class EditScreen extends StatefulWidget {
  final int id;
  const EditScreen({super.key, required this.id});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _chaveForm = GlobalKey<FormState>();
  TextEditingController _valorUserController =
      TextEditingController(text: '0.0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(Icons.edit),
              ),
              const Text(
                "Editar Gasto",
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
          key: _chaveForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.id}",
                style: TextStyle(color: Colors.black),
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
                      controller: _valorUserController,
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
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            onPressed: () {
                              adicionar10(_valorUserController);
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: 60,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                remover10(_valorUserController);
                              },
                              child: Icon(
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
                        if (_chaveForm.currentState!.validate()) {}
                      },
                      child: Text("Salvar")))
            ],
          )),
    );
  }
}

void adicionar10(TextEditingController valorUserController) {
  final double _valor = double.parse(valorUserController.text);
  final double _soma = _valor + 10;

  valorUserController.text = _soma.toString();
}

void remover10(TextEditingController valorUserController) {
  final double _valor = double.parse(valorUserController.text);
  final double _subtracao = _valor - 10;

  valorUserController.text = _subtracao.toString();
}
