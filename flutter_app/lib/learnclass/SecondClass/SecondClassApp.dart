import 'package:flutter/material.dart';
import 'package:flutterapp/LearnClass/SecondClass/ZQNewRoute.dart';
import 'package:flutterapp/LearnClass/SecondClass/ZQTipRoute.dart';

//课程文章路由管理  https://book.flutterchina.club/chapter2/
class SecondClassApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute:"/", //名为"/"的路由作为应用的home(首页)
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),routes: {
                "/":(context) => MyHomePage(title: 'Flutter Demo Home Page'), //注册首页路由
                "new_route":(context) => ZQNewRoute(),
//                "tip_route":(context) => TipRoute(text: "I love china"),
                 //补充动态参数为文本text
                "tip_route":(context) {
                    return ZQTipRoute(text: ModalRoute.of(context).settings.arguments);
                    },
                },
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;
        if (settings.name == 'new_route2') {
          builder = (BuildContext context) => ZQNewRoute();
        } else if (settings.name == 'tip_route2') {
          builder = (BuildContext context) => ZQTipRoute(text: ModalRoute.of(context).settings.arguments);
        }
        return new MaterialPageRoute(builder: builder, settings: settings);
      },
//      home: MyHomePage(title: 'Flutter Demo Home Page'),// 注意设置MyHomePage 路由注册首页方式需注释掉，否则会重复注册报错
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
      body: Center(
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
              'Hello Word sss',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
                'china'
            ),
            FlatButton(
              child: Text("open new route"),
              color: Colors.yellow,
                  onPressed: ()  async{
                    var result = await Navigator.pushNamed(context, "new_route",arguments: "my name is zhengzeqin");
//                    var result2 = await Navigator.push( //获取返回值
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return TipRoute(text: "我是提示xxxx",);// 路由参数
//                        },
//                      ),
//                    );
                    print("路由返回值: $result");
                  },
            ),
          ],
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