import 'package:flutter/material.dart';
import 'package:xlox_flutter/structure.dart';
import 'package:xlox_flutter/ui/home.dart';

Structure s = Structure(0);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
