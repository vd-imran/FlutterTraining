import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'add_item_page.dart';
import 'todo_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer<TodoProvider>(
        builder: (ctx, todoProvider, ch) => ListView.builder(
          itemCount: todoProvider.todoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${todoProvider.todoList[index]}'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo Item',
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddItemPage(),
          ),
        ),
      ),
    );
  }
}
