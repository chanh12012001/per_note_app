import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';

class CarouselSliderImageAlbum extends StatefulWidget {
  const CarouselSliderImageAlbum({Key? key}) : super(key: key);

  @override
  _CarouselSliderImageAlbumState createState() =>
      _CarouselSliderImageAlbumState();
}

class _CarouselSliderImageAlbumState extends State<CarouselSliderImageAlbum> {
  final CarouselController _controller = CarouselController();

  List _isHovering = [false, false, false, false, false, false, false];
  List _isSelected = [true, false, false, false, false, false, false];

  int _current = 0;

  final List<String> images = [
    'assets/images/main.png',
    'assets/images/main.png',
    'assets/images/animals.jpeg',
    'assets/images/main.png',
    'assets/images/animals.jpeg',
    'assets/images/main.png',
  ];

  final List<String> places = [
    'Du lich ha Long',
    'Da Lat 2021',
    'Xuan Nham Dan',
    'SOUTH AMERICA',
    'AUSTRALIA',
    'ANTARCTICA',
  ];

  List<Widget> generateImagesTiles() {
    return images
        .map((element) => ClipRRect(
              child: Image.asset(
                element,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CarouselSlider(
            items: generateImagesTiles(),
            options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 5 / 3,
                onPageChanged: (index, other) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Ảnh " + places[_current],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
