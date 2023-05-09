import 'package:flutter/material.dart';

class ItemsBottomNavigation {
  final List<BottomNavigationBarItem> _list = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicial"),
    BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: "Gastos"),
    BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Grafico")
  ];

  List<BottomNavigationBarItem> listarItems() {
    return _list;
  }
}
