import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      // home: MyHomePage(title: 'OneLogin Demo'),  // Android
      home: new CustomButtonList(titles: ['正常模式', '弹窗模式', '浮窗模式', '横屏']),  // iOS
    );
  }
}

// Android

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

// iOS

typedef void CustomButtonCallback(int tag);

class CustomButton extends StatelessWidget {
  final String title;
  final int tag;
  final CustomButtonCallback callback;

  CustomButton({this.title, this.tag, this.callback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListTile(
      onTap: () {
        callback(this.tag);
      },
      title: new Text(this.title),
    );
  }
}

class CustomButtonList extends StatefulWidget {
  final List<String> titles;

  CustomButtonList({Key key, this.titles}) : super(key: key);

  @override
  CustomButtonListState createState() {
    // TODO: implement createState
    return new CustomButtonListState();
  }
}

const MethodChannel oneLoginChannel = const MethodChannel('com.geetest.onelogin/onelogin');

Future<String> oneLogin(int tag) async {
    try {
      return await oneLoginChannel.invokeMethod('oneLogin', tag);
    } on PlatformException catch (e) {
      print('PlatformException' + e.message);
      return '-1';
    }
}

class CustomButtonListState extends State<CustomButtonList> {
  void handleButtonTapped(int tag) {
    print("您正在点击第" + tag.toString() + "个button");
    oneLogin(tag).then((message) {
      if (message == '0') {
        print("预取号失败");
      } else if (message == '1') {
        print("取号失败");
      } else if (message == '2') {
        print("获取手机号失败");
      }
    }).catchError((error) {
      print("失败:"+error.message);
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
    List<CustomButton> list = new List();
    for (var i = 0; i < widget.titles.length; i++) {
      String title = widget.titles[i];
      list.add(new CustomButton(title: title, tag: i, callback: handleButtonTapped));
    }

    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('OneLoginDemo'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: list,
      ),
    );
  }
}
