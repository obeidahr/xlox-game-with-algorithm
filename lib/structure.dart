import 'package:xlox_flutter/board.dart';

class Structure {

  // late int position_x, position_y, cost, final_x, final_y;
  // List<List<int>> path = [];
  // List<List<int>> moves_args = [];
  // List<List<bool>> visited = List.generate(
  //   11, (i) => List.generate(
  //   16, (j) => false
  //   ),
  // );

  void init() {
    //Board.staticBoard =
     
  }

  static checkOnTap(x, y) {
    if (Board.staticBoard[x][y] == 2) {
      return true;
    }
    return false;
  }

  static isFinal(){
    for (int i = 0 ; i < Board.staticBoard.length ; i++) {
      for (int j = 0; j < Board.staticBoard.length;j++) {
        if(Board.staticBoard[i][j] == 2){
          return false;
        }
      }
    }
    return true;
  }

  changeCell(x , y){
    if(Board.staticBoard[x][y] == 2){
      Board.staticBoard[x][y] = 1;
      //down
      if(Board.staticBoard[x-1][y] == 1){
        Board.staticBoard[x-1][y] = 2;
      }else if(Board.staticBoard[x-1][y] == 2){
        Board.staticBoard[x-1][y] = 1;
      } else if(Board.staticBoard[x-1][y] == 0){
          Board.staticBoard[x-1][y] = 0;
      }
      //up
      if(Board.staticBoard[x+1][y] == 1){
        Board.staticBoard[x+1][y] = 2;
      }else if(Board.staticBoard[x+1][y] == 2){
        Board.staticBoard[x+1][y] = 1;
      } else if(Board.staticBoard[x+1][y] == 0){
          Board.staticBoard[x+1][y] = 0;
      }
      //Right
      if(Board.staticBoard[x][y+1] == 1){
        Board.staticBoard[x][y+1] = 2;
      }else if(Board.staticBoard[x][y+1] == 2){
        Board.staticBoard[x][y+1] = 1;
      } else if(Board.staticBoard[x][y+1] == 0){
          Board.staticBoard[x][y+1] = 0;
      }
      //Left
      if(Board.staticBoard[x][y-1] == 1){
        Board.staticBoard[x][y-1] = 2;
      }else if(Board.staticBoard[x][y-1] == 2){
        Board.staticBoard[x][y-1] = 1;
      } else if(Board.staticBoard[x][y-1] == 0){
          Board.staticBoard[x][y-1] = 0;
      }
    }
  }

}
