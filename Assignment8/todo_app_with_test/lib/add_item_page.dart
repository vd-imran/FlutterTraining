import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'todo_provider.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new task'),
      ),
      body: TextField(
        autofocus: true,
        onSubmitted: (text) {
          provider.addTodo(text);
          Navigator.pop(context);
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          labelText: 'Enter something to do...',
        ),
      ),
    );
  }
}
