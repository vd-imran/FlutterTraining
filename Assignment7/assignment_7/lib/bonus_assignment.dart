import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "Bonus Assignment 7",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _backgroundImage = Image.asset(
    'assets/milky-way.jpg',
    fit: BoxFit.cover,
  );
  final _sunImage = Image.asset('assets/sunflr.png');

  double _sliderValue = .3;
  final _startColor = Colors.white;
  Color _newEndColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _backgroundImage,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: TweenAnimationBuilder(
                  tween: ColorTween(begin: _startColor, end: _newEndColor),
                  child: _sunImage,
                  duration: Duration(milliseconds: 800),
                  builder: (_, Color color, myChild) {
                    return ColorFiltered(
                      child: myChild,
                      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                    );
                  },
                ),
              ),
              Slider.adaptive(
                value: _sliderValue,
                onChanged: (double value) {
                  setState(() {
                    _sliderValue = value;
                    _newEndColor = Color.lerp(_startColor, Colors.red, value);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
