import 'package:flutter/material.dart';
import 'package:meu_orcamento/screens/home_screen.dart';
import 'data/hive_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 23, color: Colors.black),
          titleLarge: TextStyle(fontSize: 20),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 42, 92, 113),
                fontSize: 20,
                fontWeight: FontWeight.w600),
            iconTheme: IconThemeData(color: Color.fromARGB(255, 42, 92, 113)),
            toolbarHeight: 70,
            elevation: 8,
            shadowColor: Color.fromARGB(57, 0, 0, 0)),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 42, 92, 113),
            onPrimary: Colors.white,
            secondary: Color.fromARGB(255, 42, 92, 113),
            onSecondary: Colors.white,
            error: Colors.blueAccent,
            onError: Colors.white,
            background: Colors.blueAccent,
            onBackground: Colors.white,
            surface: Colors.blueAccent,
            onSurface: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 42, 92, 113),
            ),
            textStyle: MaterialStatePropertyAll(
              TextStyle(color: Colors.white),
            ),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromRGBO(71, 124, 147, 1),
          behavior: SnackBarBehavior.floating,
          width: 200,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
