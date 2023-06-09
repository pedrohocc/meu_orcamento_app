import 'package:flutter/material.dart';
import 'package:orcamento_app/helpers/items_bottom_navigation.dart';
import 'package:orcamento_app/helpers/screen_redirection.dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  _currentIndex(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(50, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 30,
                offset: Offset(0, 0))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
              iconSize: 25,
              unselectedIconTheme: const IconThemeData(size: 20),
              unselectedFontSize: 10,
              fixedColor: const Color.fromARGB(255, 42, 92, 113),
              unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
              elevation: 10,
              items: ItemsBottomNavigation().listarItems(),
              onTap: (value) {
                _currentIndex(value);
              },
              currentIndex: _index),
        ),
      ),
      body: ScreenRedirection(index: _index),
      extendBody: true,
    );
  }
}
