import 'package:flutter/material.dart';
import 'add_item_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${todoList[index]}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddPage,
        tooltip: 'Add Todo Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void addTodoItem(String text) {
    setState(() {
      todoList.add(text);
    });
  }

  void _goToAddPage() async {
    final String todoItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemPage(),
      ),
    );

    if (todoItem != null && todoItem.trim().isNotEmpty) {
      addTodoItem(todoItem);
    }
  }
}
