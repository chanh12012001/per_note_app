import 'package:flutter/material.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/repositories/album_repository.dart';

class AlbumProvider extends ChangeNotifier {
  AlbumRepository albumRepository = AlbumRepository();
  static List<Album> albums = [];

  // get all album
  Future<List<Album>> getAlbumsList() async {
    albums = await albumRepository.getAlbumsList();
    return albums;
  }

  Future<Album> createNewAlbum(String nameAlbum) async {
    Album newAlbum = await albumRepository.createNewAlbum(nameAlbum);
    albums.add(newAlbum);
    notifyListeners();
    return newAlbum;
  }

  Future<Map<String, dynamic>> deleteAlbum(Album album) async {
    Map<String, dynamic> result;
    result = await albumRepository.deleteAlbum(album);
    albums.remove(album);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateAlbum(Map<String, dynamic> params) async {
    Map<String, dynamic> result;
    result = await albumRepository.updateAlbum(params);
    notifyListeners();
    return result;
  }
}
