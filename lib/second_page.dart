

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_change/third_page.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Second Page'),
      ),
      body: Center(
        child: Container(
          child: GestureDetector(
            onTap: (){
              /// 点击该widget
              Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
            },
            child: Container(
              width: 100,
              height: 100,
              child: Text('跳入下一个页面'),
            ),
          ),
        ),
      ),
    );
  }

}