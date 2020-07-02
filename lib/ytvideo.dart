import 'package:http/http.dart' as http;
import 'dart:convert';
final String youtubeApiKey = "AIzaSyBKBX7jn30EzuRV70traseDBkCF-lszTu4";
class YTVideo {
  final String desc;
  final String title;
  YTVideo({this.desc, this.title});
  factory YTVideo.extractVideoData (Map<String, dynamic> parsedData) {
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
    throw Exception ("호떡좀 제대로 구워라 (Exception on youtube requests)");
  }
}