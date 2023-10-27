import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlox_flutter/cubit/xlox_state.dart';
import '../board.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //var board = Board.staticBoard;

  late int x, y;
  int colorIndex = 0;
  colored() {
    if (Board.staticBoard[x][y] == 0) {
      colorIndex = 0;
      emit(ChangeColorState());
    } else if (Board.staticBoard[x][y] == 1) {
      colorIndex = 1;
      emit(ChangeColorState());

    } else {
      colorIndex = 2;
      emit(ChangeColorState());

    }
  }

  checkOnTap(x, y) {
    if (Board.staticBoard[x][y] == 2) {
      return true;
    }
    return false;
  }

  isFinal(){
    for (int i = 0 ; i < Board.staticBoard.length ; i++) {
      for (int j = 0; j < Board.staticBoard.length;j++) {
        if(Board.staticBoard[i][j] == 2){
          return false;
        }
      }
    }
    return true;
  }

  reset() {
    Board.staticBoard = [
      [0, 0, 0, 0, 0], // 0
      [0, 1, 1, 1, 0], // 1
      [0, 1, 2, 1, 0], // 2
      [0, 1, 1, 1, 0], // 3
      [0, 0, 0, 0, 0], // 4
    ];
  }

  changeCell(x, y) {
    if (Board.staticBoard[x][y] == 2) {
      Board.staticBoard[x][y] = 1;
      //down
      if (Board.staticBoard[x - 1][y] == 1) {
        Board.staticBoard[x - 1][y] = 2;
      } else if (Board.staticBoard[x - 1][y] == 2) {
        Board.staticBoard[x - 1][y] = 1;
      } else if (Board.staticBoard[x - 1][y] == 0) {
        Board.staticBoard[x - 1][y] = 0;
      }
      //up
      if (Board.staticBoard[x + 1][y] == 1) {
        Board.staticBoard[x + 1][y] = 2;
      } else if (Board.staticBoard[x + 1][y] == 2) {
        Board.staticBoard[x + 1][y] = 1;
      } else if (Board.staticBoard[x + 1][y] == 0) {
        Board.staticBoard[x + 1][y] = 0;
      }
      //Right
      if (Board.staticBoard[x][y + 1] == 1) {
        Board.staticBoard[x][y + 1] = 2;
      } else if (Board.staticBoard[x][y + 1] == 2) {
        Board.staticBoard[x][y + 1] = 1;
      } else if (Board.staticBoard[x][y + 1] == 0) {
        Board.staticBoard[x][y + 1] = 0;
      }
      //Left
      if (Board.staticBoard[x][y - 1] == 1) {
        Board.staticBoard[x][y - 1] = 2;
      } else if (Board.staticBoard[x][y - 1] == 2) {
        Board.staticBoard[x][y - 1] = 1;
      } else if (Board.staticBoard[x][y - 1] == 0) {
        Board.staticBoard[x][y - 1] = 0;
      }
    }
  }
}
