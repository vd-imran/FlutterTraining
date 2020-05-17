import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Assignment 3';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => _buildLayout(
        context: context,
        isLandscape: orientation == Orientation.landscape,
      ),
    );
  }

  // Helper
  Widget _buildLayout({BuildContext context, bool isLandscape}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: isLandscape ? Container() : null,
      ),
      body: Row(
        children: <Widget>[
          isLandscape
              ? Expanded(
                  flex: 1,
                  child: ListPage(
                    persistent: true,
                  ),
                )
              : Container(),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: DetailPage(),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: isLandscape
          ? null
          : Drawer(
              child: SafeArea(
                child: ListPage(
                  persistent: false,
                ),
              ),
            ),
    );
  }
}

class ListPage extends StatelessWidget {
  final listItems = _createListItems(5);
  final bool persistent;

  ListPage({this.persistent, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 3,
            child: ListTile(
              title: Text(listItems[index]),
              onTap: () {
                if (!persistent) {
                  Navigator.pop(context); // Close drawer
                }
              },
            ),
          ),
        );
      },
    );
  }

  // Helper
  static List<String> _createListItems(int noOfItems) {
    final items = List<String>();
    for (int i = 1; i <= noOfItems; i++) {
      items.add('List item $i');
    }
    return items;
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => _buildLayout(constraints.maxWidth),
    );
  }

  // Helper
  Widget _buildLayout(double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            Icons.perm_identity,
            size: (width * .75) * 0.8,
          ),
          radius: (width * .75) / 2,
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: (width * .25),
          child: BoxText('VentureDive'),
        ),
      ],
    );
  }
}

class BoxText extends StatelessWidget {
  final String text;

  BoxText(this.text);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(3)),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
