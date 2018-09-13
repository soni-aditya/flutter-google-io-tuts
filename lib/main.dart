import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_flutter_tut/src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
        },
        child: ListView(
          children: _articles.map(_buildNewsItem).toList(),
        ),
      ),
    );
  }

  Widget _buildNewsItem(Article article) {
    return Padding(
      key: Key(article.id.toString()),
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(
          article.text,
          style: TextStyle(fontSize: 22.0),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${article.commentsCount} Comments'),
              IconButton(
                color: Colors.green,
                onPressed: () async {
                  var fakeUrl =
                      'https://news.ycombinator.com/from?site=hhvm.com';
                  if (await canLaunch(fakeUrl)) {
                    launch(fakeUrl);
                  }
                },
                icon: Icon(Icons.launch),
              )
            ],
          )
        ],
      ),
    );
  }
}
