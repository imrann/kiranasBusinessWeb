import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 700), (timer) {
      if (!mounted) {
        return;
      } else {
        changeOpacity();
        print("toss");
      }
    });
  }

  changeOpacity() {
    setState(() {
      if (_visible) {
        _visible = false;
      } else {
        _visible = true;
      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'NO',
                  style: TextStyle(color: Colors.pink[900]),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.pink[900]),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 700),
                      opacity: _visible ? 1.0 : 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.aspectRatio * 600,
                        child: Text(
                          'BRANDED  BANIYA',
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.pink[900],
                              fontSize: ((MediaQuery.of(context).size.width >=
                                          450.0) &&
                                      (MediaQuery.of(context).size.width <=
                                          800.0))
                                  ? 50
                                  : ((MediaQuery.of(context).size.width >
                                              800.0) &&
                                          (MediaQuery.of(context).size.width <=
                                              1100.0))
                                      ? 80
                                      : (MediaQuery.of(context).size.width >
                                              1100.0)
                                          ? 110
                                          : 20,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 1,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[getTagline("BUSINESS")],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[getTagline("Everything below MRP")],
              )
            ],
          ),
        ),
      ),
    ));
  }

  getTagline(String textToAnimate) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 700),
      opacity: _visible ? 1.0 : 0.0,
      child: Text(
        textToAnimate,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: ((MediaQuery.of(context).size.width >= 450.0) &&
                    (MediaQuery.of(context).size.width <= 800.0))
                ? 25
                : ((MediaQuery.of(context).size.width > 800.0) &&
                        (MediaQuery.of(context).size.width <= 1100.0))
                    ? 35
                    : (MediaQuery.of(context).size.width > 1100.0)
                        ? 45
                        : 15,
            wordSpacing: 1,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
