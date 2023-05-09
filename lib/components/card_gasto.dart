import 'package:flutter/material.dart';
import 'package:orcamento_app/screens/edit_gasto_screen.dart';

class CardGasto extends StatelessWidget {
  final String cardNome;
  final double cardValor;

  const CardGasto({super.key, required this.cardNome, required this.cardValor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: 250,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 61, 133, 164),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 0))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  cardNome.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "R\$ ${cardValor.toStringAsFixed(2)}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
