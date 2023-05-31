import 'package:flutter/material.dart';
import 'package:orcamento_app/components/carregamento.dart';
import 'package:orcamento_app/helpers/pdf.dart';
import 'package:orcamento_app/screens/add_new_gasto_screen.dart';
import '../components/card_gasto.dart';
import 'package:orcamento_app/data/gasto_dao.dart';

import 'edit_gasto_screen.dart';

class GastoScreen extends StatefulWidget {
  const GastoScreen({super.key});

  @override
  State<GastoScreen> createState() => _GastoScreenState();
}

class _GastoScreenState extends State<GastoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gastos"), centerTitle: true, actions: [
        IconButton(
          onPressed: () {
            PDF().getPDF();
          },
          icon: const Icon(Icons.picture_as_pdf),
        ),
        IconButton(
          onPressed: () {
            showConfirmDeleteAllGastos();
          },
          icon: const Icon(Icons.delete),
        )
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewGastoScrenn(),
              ),
            ).then((value) {
              if (value == true) {
                refresh();
              }
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/fundo.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder<List<CardGasto>>(
          future: GastoDao().getAll(),
          builder: (context, snapshot) {
            List<CardGasto>? gastosCards = snapshot.data;
            if (snapshot.connectionState != ConnectionState.done) {
              return const Carregamento();
            } else {
              if (snapshot.hasData && gastosCards != null) {
                if (gastosCards.isNotEmpty) {
                  return ListView.builder(
                    itemCount: gastosCards.length,
                    itemBuilder: (context, index) {
                      final CardGasto card = gastosCards[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditScreen(
                                id: index,
                              ),
                            ),
                          ).then((value) => refresh());
                        },
                        child: Dismissible(
                          key: Key(index.toString()),
                          background: Container(
                            color: const Color.fromARGB(255, 244, 67, 54),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          child: card,
                          onDismissed: (direction) {
                            GastoDao().deleteSingle(index);
                            refresh();
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("images/add-folder.gif",
                          fit: BoxFit.cover),
                    ),
                  );
                }
              } else {
                return Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child:
                        Image.asset("images/add-folder.gif", fit: BoxFit.cover),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void showConfirmDeleteAllGastos() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Meu Orçamento'),
          content: const Text('Deseja excluir todos os gastos?'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('NÃO'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          GastoDao().deleteAll();
                          Navigator.pop(context);
                          refresh();
                        },
                        child: const Text('SIM'),
                      )
                    ]),
              ),
            )
          ],
        );
        ;
      },
    );
  }
}
