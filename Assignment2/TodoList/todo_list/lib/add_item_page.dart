import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
        ),
        title: Text('Add a new task'),
      ),
      body: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          labelText: 'Enter something to do...',
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    super.dispose();
  }
}
