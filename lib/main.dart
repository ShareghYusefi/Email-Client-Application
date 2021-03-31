import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.blue,
      ),
      home: MyHomePage(title: 'This is the Homepage'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  var messages = const [
    'Avenir Next Condensed',
    'Academy Engraved LET',
    'Arial Rounded MT Bold',
    'Bangla Sangam MN',
    'Kohinoor Bangla'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          var title = messages[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text('PJ'),
            ),
            title: Text(title),
            subtitle: Text('Another line of text'),
            isThreeLine: true,
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}