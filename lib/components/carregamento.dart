import 'package:flutter/material.dart';

class Carregamento extends StatelessWidget {
  const Carregamento({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(children: [
        CircularProgressIndicator(),
        Text("Carregando..."),
      ]),
    );
  }
}
