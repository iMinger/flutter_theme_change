import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_theme_change/fourth_page.dart';
import 'package:flutter_theme_change/theme_change_manager.dart';
import 'package:provider/provider.dart';

Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.deepPurple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThirdPageState();
  }
}

class _ThirdPageState extends State<ThirdPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Third page initState 执行');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('Third page didChangeDependencies 执行');
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('Third page build 执行');
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Third Page'),
        ),
        body: Column(
          children: [
            ExpansionTile(
              leading: Icon(Icons.color_lens),
              title: Text('颜色主题'),
              initiallyExpanded: false,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ThemeChangeManager().themeColorMap.keys.map((key) {
                      Color value = ThemeChangeManager().themeColorMap[key]!;
                      return InkWell(
                        onTap: () {
                          Provider.of<ThemeChangeManager>(context, listen: false)
                              .setTheme(key);
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          color: value,
                          child: ThemeChangeManager().themeKey == key
                              ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            SizedBox(height: 200),
            GestureDetector(
              onTap: () {
                /// 点击该widget
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FourthPage()));
              },
              child: Container(
                width: 100,
                height: 100,
                child: Text('跳入下一个页面'),
              ),
            ),
          ],
        ));
  }
}
