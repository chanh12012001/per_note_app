import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/first_image_album_slider_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/album_provider.dart';
import '../loader.dart';
import '../storage_manage/album/images/image_list.dart';

class CarouselSliderImageAlbum extends StatefulWidget {
  const CarouselSliderImageAlbum({Key? key}) : super(key: key);

  @override
  _CarouselSliderImageAlbumState createState() =>
      _CarouselSliderImageAlbumState();
}

class _CarouselSliderImageAlbumState extends State<CarouselSliderImageAlbum> {
  final CarouselController _controller = CarouselController();

  int _current = 0;

  List<FirstImageAlbumSlider> images = [];

  List<Widget> generateImagesTiles() {
    return images
        .map((element) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ImageList(album: element.album!),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  element.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    AlbumProvider albumProvider = Provider.of<AlbumProvider>(context);
    return FutureBuilder<List<FirstImageAlbumSlider>>(
      future: albumProvider.getAllFirstImageAlbumSliderList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          images = snapshot.data!;
        }
        return snapshot.hasData
            ? Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    CarouselSlider(
                      items: generateImagesTiles(),
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          height: MediaQuery.of(context).size.width / 1.7,
                          aspectRatio: 5 / 3,
                          onPageChanged: (index, other) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    snapshot.data!.isNotEmpty ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Text(
                          "Ảnh ${images[_current].album!.name!}",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ):Container(),
                  ],
                ),
              )
            : const Center(
                child: ColorLoader(),
              );
      },
    );
  }
}
