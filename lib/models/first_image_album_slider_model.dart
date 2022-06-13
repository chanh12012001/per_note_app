import 'package:per_note/models/album_model.dart';

class FirstImageAlbumSlider {
  Album? album;
  String? image;

  FirstImageAlbumSlider({this.album, this.image});

  FirstImageAlbumSlider.fromJson(Map<String, dynamic> json) {
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    image = json['image'];
  }
}
