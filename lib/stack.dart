import 'dart:collection';

class Stack<T> {
  final _stack = Queue<T>();

  int get length => _stack.length;

  bool isNotEmpty() => _stack.isNotEmpty;
  
  void removeLast(){
    while(_stack.isNotEmpty){
      _stack.removeLast();
    }
  }

  void push(T element) {
    _stack.addLast(element);
  }

  T pop() {
    T lastElement = _stack.last;
    _stack.removeLast();
    return lastElement;
  }

  T peak() => _stack.last;

}