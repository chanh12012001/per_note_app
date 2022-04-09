import 'dart:io';

import 'package:flutter/material.dart';
import 'package:per_note/repositories/image_repository.dart';

import '../models/image_model.dart';

class ImagesProvider extends ChangeNotifier {
  ImageRepository imageRepository = ImageRepository();
  static List<ImageModel> images = [];

  // get all images by album id
  Future<List<ImageModel>> getAllImagesByAlbumId(albumId) async {
    images = await imageRepository.getAllImagesByAlbumId(albumId);
    // notifyListeners();
    return images;
  }

  Future uploadImagesToAlbum(albumId, List<File> images) async {
    await imageRepository.uploadImagesToAlbum(albumId, images);
    notifyListeners();
  }

  Future<Map<String, dynamic>> deleteImagesOfAlbum(String imagesIds) async {
    Map<String, dynamic> result;
    debugPrint(imagesIds);
    result = await imageRepository.deleteImagesOfAlbum(imagesIds);
    //albums.remove(album);
    notifyListeners();
    return result;
  }
}
