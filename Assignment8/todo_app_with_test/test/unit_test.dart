// Import the test package and Counter class
import 'package:test/test.dart';

import 'package:todoappwithtest/todo_provider.dart';

void main() {
  test('Counter value should be incremented', () {
    final sampleTodo = 'This is a samle todo';
    final provider = TodoProvider();

    expect(provider.todoList.length, 0);

    provider.addTodo(sampleTodo);

    expect(provider.todoList.length, 1);
    expect(provider.todoList.first, sampleTodo);
  });
}
