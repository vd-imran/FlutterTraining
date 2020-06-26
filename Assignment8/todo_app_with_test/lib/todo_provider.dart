import 'package:flutter/cupertino.dart';

class TodoProvider with ChangeNotifier {
  List<String> _todoList = [];
  List<String> get todoList => List.unmodifiable(_todoList);

  void addTodo(String item) {
    final val = item?.trim() ?? "";

    if (val.isEmpty) {
      return;
    }

    _todoList.add(item);
    notifyListeners();
  }
}
