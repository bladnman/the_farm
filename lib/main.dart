import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_farm/GameEngine.dart';
import 'package:the_farm/widgets/playground/Playground.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Welcome to the Farm!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GameEngine game = GameEngine();
  bool isActive = true;
  Timer t;

  void scheduleRedraw() {
    // dis-schedule it
    if (!isActive) {
      t.cancel();
      t = null;
      return;
    }
    // already scheduled
    if (t != null) return;

    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        game.update();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    scheduleRedraw();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double width = widthScreen - widthScreen * .2;
    double height = heightScreen - heightScreen * .2;
    game.size = Size(width, height);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  isActive = !isActive;
                });
              },
              child: Playground(
                color: Colors.black87,
                width: width,
                height: height,
                actors: game.actors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
