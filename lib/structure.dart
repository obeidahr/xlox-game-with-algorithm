// ignore_for_file: avoid_print
import 'dart:collection';
import 'package:collection/collection.dart';
import 'dart:math';
import 'package:xlox_flutter/stack.dart';

class Structure {
  List<List<int>> staticBoard = [];
  int cost;
  int depthOfBfs = 0;
  int depthOfDfs = 0;
  int depthOfucs = 0;
  int depthOfhill = 0;
  int depthOfA= 0;

  Structure(this.cost) {
    //initail state
    staticBoard = [
      //level 1
      // 0  1  2  3  4
      // [0, 0, 0, 0, 0], // 0
      // [0, 1, 1, 1, 0], // 1
      // [0, 1, 2, 1, 0], // 2
      // [0, 1, 1, 1, 0], // 3
      // [0, 0, 0, 0, 0], // 4

// "0 ,0 ,0 , 0, 0",
// "0 ,1 ,1 , 1, 0",
// "0 ,1 ,2 , 1, 0",
// "0 ,1 ,1 , 1, 0",
// "0 ,0 ,0 , 0, 0",

      // //level 6
      // [0, 0, 0, 0, 0, 0, 0], // 0
      // [0, 1, 1, 1, 1, 1, 0], // 1
      // [0, 2, 0, 2, 0, 2, 0], // 2
      // [0, 1, 1, 1, 1, 1, 0], // 3
      // [0, 0, 0, 0, 0, 0, 0], // 4
      //
      //level 4
      [0,0,0,0,0],
      [0,1,1,1,0],
      [0,1,0,1,0],
      [0,2,0,2,0],
      [0,0,0,0,0],
      //level 7
      // [0,0,0,0,0],
      // [0,1,1,1,0],
      // [0,0,0,2,0],
      // [0,1,1,1,0],
      // [0,2,0,0,0],
      // [0,1,1,1,0],
      // [0,0,0,0,0],
    ];
  }

  int countNodedfs = 0;
  int countNodebfs = 0;
  int countNodeucs = 0;
  int countNodehill = 0;
  int countNodeA = 0;

  //deep copy for nodes
  // Structure deepCopy() {
  //   List<List<int>> newState = [];
  //   for (int i = 0; i < staticBoard.length; i++) {
  //     List<int> row = [];
  //     for (int j = 0; j < staticBoard[i].length; j++) {
  //       row.add(staticBoard[i][j]);
  //     }
  //     newState.add(row);
  //   }
  //   Structure newNode = Structure();
  //   return newNode;
  // }

  deepCopy() {
    Structure s = Structure(0);
    for (int i = 0; i < staticBoard.length; i++) {
      for (int j = 0; j < staticBoard[i].length; j++) {
        s.staticBoard[i][j] = staticBoard[i][j];
      }
    }
    return s;
  }

  bool isValid(p) {
    int x = p[0];
    int y = p[1];
    return 0 <= x &&
        x <= staticBoard.length &&
        0 <= y &&
        y <= staticBoard.length &&
        staticBoard[x][y] != 0;
  }

  //return Action for current state
  // ignore: non_constant_identifier_names
  next_state(p) {
    int x = p[0];
    int y = p[1];

    List states = [];
    for (var d in [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ]) {
      int nx = x - d[0];
      int ny = y - d[1];
      if (isValid([nx, ny])) {
        states.add([nx, ny]);
      }
    }
    return states;
  }

  @override
  String toString() {
    return 'node:$staticBoard,depthof hill:$depthOfhill,UCS:$depthOfucs,BFS:$depthOfBfs,DFS:$depthOfDfs,A:$depthOfA';
  }

  //work action
  checkOnTap(p) {
    if (staticBoard[p[0]][p[1]] == 2) {
      return true;
    }
    return false;
  }

  //goal state
  isFinal() {
    for (int i = 0; i < staticBoard.length; i++) {
      for (int j = 0; j < staticBoard[i].length; j++) {
        if (staticBoard[i][j] == 2) {
          return false;
        }
      }
    }
    return true;
  }

  changeCell(p) {
    if (staticBoard[p[0]][p[1]] == 2) {
      staticBoard[p[0]][p[1]] = 1;
      //down
      if (staticBoard[p[0] - 1][p[1]] == 1) {
        staticBoard[p[0] - 1][p[1]] = 2;
      } else if (staticBoard[p[0] - 1][p[1]] == 2) {
        staticBoard[p[0] - 1][p[1]] = 1;
      } else if (staticBoard[p[0] - 1][p[1]] == 0) {
        staticBoard[p[0] - 1][p[1]] = 0;
      }
      //up
      if (staticBoard[p[0] + 1][p[1]] == 1) {
        staticBoard[p[0] + 1][p[1]] = 2;
      } else if (staticBoard[p[0] + 1][p[1]] == 2) {
        staticBoard[p[0] + 1][p[1]] = 1;
      } else if (staticBoard[p[0] + 1][p[1]] == 0) {
        staticBoard[p[0] + 1][p[1]] = 0;
      }
      //Right
      if (staticBoard[p[0]][p[1] + 1] == 1) {
        staticBoard[p[0]][p[1] + 1] = 2;
      } else if (staticBoard[p[0]][p[1] + 1] == 2) {
        staticBoard[p[0]][p[1] + 1] = 1;
      } else if (staticBoard[p[0]][p[1] + 1] == 0) {
        staticBoard[p[0]][p[1] + 1] = 0;
      }
      //Left
      if (staticBoard[p[0]][p[1] - 1] == 1) {
        staticBoard[p[0]][p[1] - 1] = 2;
      } else if (staticBoard[p[0]][p[1] - 1] == 2) {
        staticBoard[p[0]][p[1] - 1] = 1;
      } else if (staticBoard[p[0]][p[1] - 1] == 0) {
        staticBoard[p[0]][p[1] - 1] = 0;
      }
    }
  }

  checkMoves(p) {
    List chCell = [];
    if (staticBoard[p[0] - 1][p[1]] != 0) {
      chCell.add(staticBoard[p[0] - 1][p[1]]);
    }
    if (staticBoard[p[0] + 1][p[1]] != 0) {
      chCell.add(staticBoard[p[0] + 1][p[1]]);
    }
    if (staticBoard[p[0]][p[1] + 1] != 0) {
      chCell.add(staticBoard[p[0]][p[1] + 1]);
    }
    if (staticBoard[p[0]][p[1] - 1] != 0) {
      chCell.add(staticBoard[p[0]][p[1] - 1]);
    }
    return chCell.length;
  }

  dfs(node) {
    Stack stack = Stack();
    stack.push(node);
    Map<dynamic, dynamic> visited = {node:null};
    while (stack.isNotEmpty()) {
      countNodedfs++;
      Structure vertex = stack.pop();
      if (vertex.isFinal()) {
        print("solution! Found");
        print(countNodedfs);
        depthOfDfs = countNodedfs - 1 ;
        List path = [vertex];
        while (visited[vertex] != null) {
          vertex = visited[vertex];
          path.add(vertex);
        }
        for (var coordinate in path.reversed) {
          print(coordinate.toString());
        }
        return;
      }
      for (var neighbor in gNextStates(vertex)) {
        if (!visited.containsKey((element) => element == neighbor)) {
          stack.push(neighbor);
          visited[neighbor] = vertex;
        }
      }
    }
    print("No Solutin");
  }

  int calculateDepth(int visited) {
    return (log(visited + 1) / log(2)).ceil();
  }

  bfs(node) {
    Queue queue = Queue();
    queue.add(node);
    Map<dynamic, dynamic> discovered = {node: null};
    while (queue.isNotEmpty) {
      countNodebfs++;
      Structure vertex = queue.removeFirst();
      if (vertex.isFinal()) {
        print("solution Found!");
        print(countNodebfs);
        depthOfBfs = calculateDepth(countNodebfs);
        List path = [vertex];
        while (discovered[vertex] != null) {
          vertex = discovered[vertex];
          path.add(vertex);
        }
        for (var coordinate in path.reversed) {
          print(coordinate.toString());
        }
        return;
      }
      for (var nextState in gNextStates(vertex)) {
        if (!discovered.containsKey((element) => element == nextState)) {
          queue.add(nextState);
          discovered[nextState] = vertex;
        }
      }
    }
    print("No solution");
  }


  //Apply a move by selecting one of the lit blocks.
  move() {
    List whiteCell = [];
    for (int i = 0; i < staticBoard.length; i++) {
      for (int j = 0; j < staticBoard[i].length; j++) {
        if (staticBoard[i][j] == 2) {
          whiteCell.add([i, j]);
        }
      }
    }
    var randomCellOfWhite = whiteCell[Random().nextInt(whiteCell.length)];
    // int x = randomCellOfWhite[0];
    // int y = randomCellOfWhite[1];
    // staticBoard[[x][y]] == 1;
    changeCell(randomCellOfWhite);
    return staticBoard;
  }

  //generate N structure(state - node) objects by copying
  //current structure (deep copy),
  gNextStates(Structure b) {
    int x = 0;
    for (int i = 0; i < b.staticBoard.length; i++) {
      for (int j = 0; j < b.staticBoard[i].length; j++) {
        if (b.staticBoard[i][j] == 2) {
          x++;
        }
      }
    }
    List<Structure> l = [];
    while (x > l.length) {
      Structure v = b.deepCopy();
      v.move();
      l.add(v);
      if (!l.any((number) => number == v)) {
        l.add(v);
      }
    }
    return l;
  }

  bool areNodesEqual(Structure node1, Structure node2) {
    return node1.staticBoard == node2.staticBoard;
  }

  bool areBoardsEqual(List<List<int>> board1, List<List<int>> board2) {
    if (board1.length != board2.length) {
      return false;
    }
    for (int i = 0; i < board1.length; i++) {
      if (board1[i].length != board2[i].length) {
        return false;
      }
      for (int j = 0; j < board1[i].length; j++) {
        if (board1[i][j] != board2[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  uniformCostSearch(start) {
    PriorityQueue<Structure> queue = PriorityQueue<Structure>((a, b) => a.cost.compareTo(b.cost));
    queue.add(start);
    Map<Structure, dynamic> discovered = {start: null};
    while (queue.isNotEmpty) {
      countNodeucs++;
      Structure current = queue.removeFirst();
      if (current.isFinal()) {
        print("Sol");
        print(countNodeucs);
        depthOfucs = calculateDepth(countNodeucs);
        List path = [current];
        while (discovered[current] != null) {
          current = discovered[current];
          path.add(current);
        }
        for (var coordinate in path.reversed) {
          print(coordinate.toString());
        }
        print(path.length-1);
        print(discovered.length);
        return;
      }
      for (var nextState in gNextStates(current)) {
        int cost = current.cost + 1; // cost of the path to the neighbor
        nextState.cost = cost;
        //print(cost);
        //Structure newStructure = Structure(current,cost);
          // ..staticBoard = nextState.staticBoard
          // ..parent = current
          // ..cost = cost;
        if (!discovered.containsKey((element) => element == nextState)) {
          queue.add(nextState);
          discovered[nextState] = current;
        }
      }
    }
    print("No Soli");
  }

  int heu(Structure b){
    int x = 0;
    for (int i = 0; i < b.staticBoard.length; i++) {
      for (int j = 0; j < b.staticBoard[i].length; j++) {
        if (b.staticBoard[i][j] == 2) {
          x++;
        }
      }
    }
    return x;
  }

  hill(Structure start) {
    PriorityQueue<Structure> queue = PriorityQueue<Structure>((a, b) => (a.cost).compareTo(b.cost));
    queue.add(start);
    Map<Structure, dynamic> discovered = {start: null};
    var costs = <dynamic, int>{start : 0};
    while (queue.isNotEmpty) {
      countNodehill++;
      var current = queue.removeFirst();
      if (current.isFinal()) {
        print("Found sol");
        print(countNodehill);
        depthOfhill = calculateDepth(countNodehill);
        var path = [current];
        while (discovered[current] != null) {
          current = discovered[current];
          path.add(current);
        }
        for (var coordinate in path.reversed) {
          print(coordinate.toString());
        }
        print(path.length-1);
        print(discovered.length);
        return;
      }
      for (var neighbor in gNextStates(current)) {
        dynamic newCost = costs[current]! + neighbor.cost;
        if (!costs.containsKey(neighbor)) {
          costs[neighbor] = newCost;
          neighbor.cost = newCost;
          //print(heu(neighbor));
          queue.add(neighbor);
          discovered[neighbor] = current;
        }
      }
    }
    print("No Solution");
  }

  aStar(Structure start) {
    PriorityQueue<Structure> queue = PriorityQueue<Structure>((a, b) => (a.cost).compareTo(b.cost));
    queue.add(start);
    Map<Structure, dynamic> discovered = {start: null};
    var costs = <Structure, int>{start: 0};
    while (queue.isNotEmpty) {
      countNodeA++;
      var current = queue.removeFirst();
      if (current.isFinal()) {
        print("Found sol");
        print(countNodeA);
        depthOfA = calculateDepth(countNodeA);
        var path = [current];
        while (discovered[current] != null) {
          current = discovered[current];
          path.add(current);
        }
        for (var coordinate in path.reversed) {
          print(coordinate.toString());
        }
        print(path.length-1);
        print(discovered.length);
        return;
      }
      for (var neighbor in gNextStates(current)) {
        dynamic newCost = costs[current]! + neighbor.cost;
        if (!costs.containsKey(neighbor)) {
          costs[neighbor] = newCost;
          neighbor.cost = newCost + heu(neighbor);
          queue.add(neighbor);
          discovered[neighbor] = current;
        }else{
            discovered.remove(neighbor);
          }
      }
    }
    // No solution found
    print("No Solution");
  }
}
