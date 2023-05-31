import 'package:flutter/material.dart';
import 'package:orcamento_app/screens/charts_screen.dart';
import 'package:orcamento_app/screens/gastos_screen.dart';
import 'package:orcamento_app/screens/initial_screen.dart';

class ScreenRedirection extends StatefulWidget {
  final int index;
  const ScreenRedirection({super.key, required this.index});

  @override
  State<ScreenRedirection> createState() => _ScreenRedirectionState();
}

class _ScreenRedirectionState extends State<ScreenRedirection> {
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        return const InitialScreen();
      case 1:
        return const GastoScreen();
      case 2:
        return const ChartScreen();
      default:
        return Container();
    }
  }
}
