import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlox_flutter/cubit/xlox_cubit.dart';
import '../board.dart';
import '../cubit/xlox_state.dart';
import '../utils.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          if (Board.staticBoard[cubit.x][cubit.y] == 0) {
            cubit.colorIndex = 0;
          } else if (Board.staticBoard[cubit.x][cubit.y] == 1) {
            cubit.colorIndex = 1;
          } else {
            cubit.colorIndex = 2;
          }
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.restart_alt_outlined),
                onPressed: () {
                  cubit.reset();
                }),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // generate the board
                ...List.generate(
                  5,
                  (i) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        5,
                        (j) => Padding(
                              padding: const EdgeInsets.all(1.3),
                              child: InkWell(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        //border: Border.all(width: 2),
                                        color: colorCell[cubit.colorIndex],
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (kDebugMode) {
                                      print(cubit.colorIndex);
                                    }
                                    if (cubit.checkOnTap(i, j)) {
                                      if (kDebugMode) {
                                        print("White Cell");
                                      }

                                      cubit.changeCell(i, j);
                                      if (kDebugMode) {
                                        print(Board.staticBoard);
                                      }
                                    }
                                    if (cubit.isFinal()) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title:
                                                    const Text('you A Winner!'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text(
                                                        'Play Again'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ));
                                      if (kDebugMode) {
                                        print("Winner!");
                                      }
                                    }
                                  }),
                            )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
