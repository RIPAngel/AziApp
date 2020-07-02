import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
final String youtubeApiKey = "AIzaSyBKBX7jn30EzuRV70traseDBkCF-lszTu4";

class YTVideo {
  final String desc;
  final String title;
  YTVideo({this.desc, this.title});
  factory YTVideo.extractVideoData (Map<String, dynamic> parsedData) {
    print(parsedData['items'][0]);
    return YTVideo(
      desc: parsedData['items'][0]['snippet']['description'],
      title: parsedData['items'][0]['snippet']['title'],
    );
  }
}

Future<YTVideo> fetchAziYT() async {
  final resp = await http.get('https://www.googleapis.com/youtube/v3/videos?part=snippet&id=5zvqZkPzQ1Q&key=$youtubeApiKey');
  if (resp.statusCode == 200) {
    YTVideo returnValue = YTVideo.extractVideoData(json.decode(resp.body));
    return returnValue;
  } else {
    throw Exception ("호떡좀 제대로 구워라");
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<YTVideo> videoData;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Azi_YT',
      style: optionStyle,
    ),
    Text(
      'Index 1: Azi_SNS',
      style: optionStyle,
    ),
    Text(
      'Index 2: Azi_Info',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    videoData = fetchAziYT();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fetching YangAzi Youtube Metadata',
      home: Scaffold(
        appBar: AppBar(
          title: Text('fetching YangAzi Youtube Metadata'),
        ),
        body: Center (
            child: FutureBuilder<YTVideo> (
              future: videoData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _widgetOptions.elementAt(_selectedIndex);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              return CircularProgressIndicator();
              }
            )  
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('아지 유튜브'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('아지 SNS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('아지 정보'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        ),
      ),
    );
  }
}