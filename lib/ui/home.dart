import 'package:flutter/material.dart';
import 'package:xlox_flutter/position.dart';
import '../cell.dart';
import '../main.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   super.initState();
  //   s.bfsState([2,3], s.isFinal());
  // }
  void refreshCell() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
              child: const Text("ucs"),
              onPressed: () {
                  //s.move();
                  s.uniformCostSearch(s);
              }),
          FloatingActionButton(
              child: const Text("bfs"),
              onPressed: () {
                  s.bfs(s);
              }),
          FloatingActionButton(
              child: const Text("dfs"),
              onPressed: () {
                  s.dfs(s);
              }),
          FloatingActionButton(
              child: const Text("A*"),
              onPressed: () {
                  s.aStar(s);
              }),
          FloatingActionButton(
              child: const Text("hill"),
              onPressed: () {
                  s.hill(s);
              }),
          FloatingActionButton(
              child: const Icon(Icons.restart_alt_outlined),
              onPressed: () {
                setState(() {
                  s.staticBoard = [
                    //level 6
                    // [0, 0, 0, 0, 0, 0, 0], // 0
                    // [0, 1, 1, 1, 1, 1, 0], // 1
                    // [0, 2, 0, 2, 0, 2, 0], // 2
                    // [0, 1, 1, 1, 1, 1, 0], // 3
                    // [0, 0, 0, 0, 0, 0, 0], // 4
                    // [0, 0, 0, 0, 0], // 0
                    // [0, 1, 1, 1, 0], // 1
                    // [0, 1, 2, 1, 0], // 2
                    // [0, 1, 1, 1, 0], // 3
                    // [0, 0, 0, 0, 0], // 4
                    // [0,0,0,0,0],
                    // [0,1,1,1,0],
                    // [0,1,0,1,0],
                    // [0,2,0,2,0],
                    // [0,0,0,0,0],
                    [0,0,0,0,0],
                    [0,1,1,1,0],
                    [0,0,0,2,0],
                    [0,1,1,1,0],
                    [0,2,0,0,0],
                    [0,1,1,1,0],
                    [0,0,0,0,0],
                  ];
                  s.countNodebfs = 0;
                  s.countNodedfs = 0;
                  // s.move();
                  // print(s.gNextStates(s));
                });
              }),
        ],
      ),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // generate the board
            ...List.generate(
              s.staticBoard.length, //rows
              (i) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  s.staticBoard[i].length,
                  (j) => Cell(refresh: refreshCell,p: Position(x: i, y: j)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
