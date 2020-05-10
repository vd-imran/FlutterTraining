import 'package:flutter/material.dart';

class ChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _createChatList(),
    );
  }

  List<Widget> _createChatList({int noOfChats = 20}) {
    List<Widget> list = [];

    for (int i = 0; i < noOfChats; i++) {
      list.add(_createListTile(title: 'Contact ${i + 1}'));
    }

    return list;
  }

  ListTile _createListTile(
      {@required String title,
      String subtitle = 'Hi there!',
      String time = '2:53 am'}) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.perm_identity),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        time,
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
