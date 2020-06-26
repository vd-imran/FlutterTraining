import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, text);
          },
        ),
        title: Text('Add a new task'),
      ),
      body: TextField(
        autofocus: true,
        onChanged: (newValue) {
          text = newValue;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(13),
          labelText: 'Enter something to do...',
        ),
      ),
    );
  }
}
