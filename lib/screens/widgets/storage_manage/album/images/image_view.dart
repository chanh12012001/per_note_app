import 'package:flutter/material.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/image_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  final List<ImageModel>? images;
  final int? currentIndex;
  const ImageView({
    Key? key,
    this.images,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentIndex!);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteColor),
          onPressed: () => Navigator.of(_scaffoldKey.currentContext!).pop(),
        ),
      ),
      body: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.images!.length,
        builder: (context, index) {
          final imageUrl = widget.images![index].imageUrl;
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(imageUrl!),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.contained * 4,
          );
        },
      ),
    );
  }
}
