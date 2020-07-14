import 'package:youtube_explode_dart/youtube_explode_dart.dart';

Future<Video> fetchAziYT() async {
  var yt = YoutubeExplode();
  var id = VideoId("UnLXqIrLngM");
  var video = await yt.videos.get(id);
  return video;
}
