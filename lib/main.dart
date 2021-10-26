import 'package:flutter/material.dart';
import 'package:flutter_theme_change/second_page.dart';
import 'package:flutter_theme_change/theme_change_manager.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

void main() async{

  /// [重要] 确保插件都初始化了
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: ThemeChangeManager())],
      child: Consumer<ThemeChangeManager>(
        builder: (context, manager, childWidget) {

          return MaterialApp(
            title: 'Flutter Demo',
            theme: manager.currentThemeDataObject.themeData,
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await SpUtil.getInstance();

    /// 设置初始化主题颜色
    // Provider.of<ThemeChangeManager>(context, listen: false).setTheme(_colorKey);
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: ThemeChangeManager().currentThemeDataObject.themeData.backgroundColor
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),

              SizedBox(
                height: 200,
              ),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
