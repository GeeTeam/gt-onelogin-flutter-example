import 'package:flutter/material.dart';
import 'channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OneLogin Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'OneLogin Demo'),
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
  void _oneLoginBegin() {
    Channel.oneLoginBegin()
        .then((message) {
      if (!mounted) {
        return;
      }
      print(message);
    }).catchError((error) {
      if (!mounted) {
        return;
      }
      switch (error.code) {
        case '0':
          print("预取号失败:"+error.message);
          break;
        case '1':
          print("取号失败:"+error.message);
          break;
        case '2':
          print("获取手机号失败:"+error.message);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to OneLogin!',
            ),
            new FlatButton(
              child: new Text("Trigger OneLogin"),
              onPressed: () {
                _oneLoginBegin();
              },
            ),
          ],
        ),
      ),
    );
  }
}
