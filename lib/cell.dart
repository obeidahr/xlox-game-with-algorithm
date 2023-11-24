// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xlox_flutter/position.dart';
import 'package:xlox_flutter/utils.dart';
import 'main.dart';

// ignore: must_be_immutable
class Cell extends StatefulWidget {
  Function() refresh;
  int colorIndex = 0;
  Position p;
  Cell({super.key, required this.refresh, required this.p});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    if (s.staticBoard[widget.p.x][widget.p.y] == 0) {
      widget.colorIndex = 0;
    } else if (s.staticBoard[widget.p.x][widget.p.y] == 1) {
      widget.colorIndex = 1;
    } else {
      widget.colorIndex = 2;
    }

    return Padding(
      padding: const EdgeInsets.all(1.3),
      child: InkWell(
          child: SizedBox(
            width: 50,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                color: colorCell[widget.colorIndex],
              ),
            ),
          ),
          onTap: () {
            //print(s.depthOfhill);
            // s.bfsState([2,2], s.isFinal());
            print(s.cost);
            if (s.checkOnTap([widget.p.x,widget.p.y])) {
              if (kDebugMode) {
                print("White Cell");
              }
              s.changeCell([widget.p.x,widget.p.y]);
              widget.refresh();
              if (kDebugMode) {
               // print("now: ${s.staticBoard}");
                //print("next State: ${s.getNextState(s)}");
                //print(s.next_state([widget.p.x,widget.p.y]));
               
                //print(s.countNodedfs);
                // s.bfs(s.getNextState(s));
                // print(s.countNodebfs);
              }
            }
            if (s.isFinal()) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('you A Winner!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Play Again'),
                            onPressed: () {
                              widget.refresh();
                              s.staticBoard = [
                                // [0, 0, 0, 0, 0],
                                // [0, 1, 1, 1, 0],
                                // [0, 1, 2, 1, 0],
                                // [0, 1, 1, 1, 0],
                                // [0, 0, 0, 0, 0],
                                //level 6
                                // [0, 0, 0, 0, 0, 0, 0], // 0
                                // [0, 1, 1, 1, 1, 1, 0], // 1
                                // [0, 2, 0, 2, 0, 2, 0], // 2
                                // [0, 1, 1, 1, 1, 1, 0], // 3
                                // [0, 0, 0, 0, 0, 0, 0], // 4
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
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
              if (kDebugMode) {
                print("Winner!");
              }
            }
          }),
    );
  }
}
