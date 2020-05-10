import 'package:flutter/material.dart';
import 'constants.dart';
import 'chats_tab.dart';
import 'camera_tab.dart';
import 'status_tab.dart';
import 'calls_tab.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('WhatsApp'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(
                icon: _createTextTab('CHATS'),
              ),
              Tab(
                icon: _createTextTab('STATUS'),
              ),
              Tab(
                icon: _createTextTab('CALLS'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CameraTab(),
            ChatsTab(),
            StatusTab(),
            CallsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.chat),
        ),
      ),
    );
  }

  Widget _createTextTab(String text) {
    return Text(
      text,
      style: tabBarTextStyle,
    );
  }
}
