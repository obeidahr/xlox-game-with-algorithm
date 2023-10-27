import 'package:flutter/material.dart';
import '../board.dart';
import '../cell.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void refreshCell() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.restart_alt_outlined),
          onPressed: () {
            setState(() {
              Board.staticBoard = [
                [0, 0, 0, 0, 0], // 0
                [0, 1, 1, 1, 0], // 1
                [0, 1, 2, 1, 0], // 2
                [0, 1, 1, 1, 0], // 3
                [0, 0, 0, 0, 0], // 4
              ];
            });
          }),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // generate the board
            ...List.generate(
              5,
              (i) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (j) => Cell(refresh: refreshCell, x: i, y: j),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
