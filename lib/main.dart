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

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<YTVideo> videoData;
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
                  return Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network("https://i.ytimg.com/vi/5zvqZkPzQ1Q/0.jpg"),
                      Text(snapshot.data.title),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              return CircularProgressIndicator();
              }
            )  
        ),
      ),
    );
  }
}