import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xlox_flutter/board.dart';
import 'package:xlox_flutter/structure.dart';
import 'package:xlox_flutter/utils.dart';
import 'main.dart';

// ignore: must_be_immutable
class Cell extends StatefulWidget {
  Function() refresh;
  int x, y, colorIndex = 0;
  Cell({super.key, required this.refresh, required this.x, required this.y});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    if (Board.staticBoard[widget.x][widget.y] == 0) {
      widget.colorIndex = 0;
    } else if (Board.staticBoard[widget.x][widget.y] == 1) {
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
            if (Structure.checkOnTap(widget.x, widget.y)) {
              if (kDebugMode) {
                print("White Cell");
              }
              S.changeCell(widget.x, widget.y);
              widget.refresh();
              if (kDebugMode) {
                print(Board.staticBoard);
              }
            }
            if (Structure.isFinal()) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('you A Winner!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Play Again'),
                            onPressed: () {
                              widget.refresh();
                              Board.staticBoard = [
                                [0, 0, 0, 0, 0],
                                [0, 1, 1, 1, 0],
                                [0, 1, 2, 1, 0],
                                [0, 1, 1, 1, 0],
                                [0, 0, 0, 0, 0],
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
