import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/models/image_model.dart';
import 'package:per_note/screens/widgets/storage_manage/album/images/image_view.dart';
import 'package:per_note/screens/widgets/storage_manage/album/images/image_card.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/image_provider.dart';
import '../../../../../providers/loading_provider.dart';
import '../../../../../services/toast_service.dart';
import '../../../alert_dialog.dart';
import '../../../loader.dart';

class ImageList extends StatefulWidget {
  final Album album;
  const ImageList({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<ImageList> createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile>? _imageFileList = [];
  final List<File>? _imageFiles = [];
  HashSet selectedItems = HashSet();
  bool isSelected = false;
  List<dynamic> imageIds = [];
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    ImagesProvider _imageProvider = Provider.of<ImagesProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.album.name!,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          isSelected == false
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = true;
                        });
                      },
                      child: Text(
                        'Select',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        selectAndUploadImages(widget.album.id, _imageFiles!);
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ],
                )
              : TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isSelected = false;
                      selectedItems.clear();
                    });
                  },
                )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<ImageModel>>(
            future: _imageProvider.getAllImagesByAlbumId(widget.album.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return snapshot.hasData
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              ImageModel image = snapshot.data![index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelected
                                            ? doMultiSelection(image.id!)
                                            : openImageGalleryView(
                                                snapshot.data!,
                                                index,
                                                context,
                                              );
                                      },
                                      child: ImageCard(
                                        image: image,
                                        isSelected: isSelected,
                                        selectedItems: selectedItems,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : const Center(
                      child: ColorLoader(),
                    );
            },
          ),
          isSelected == true
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey[300],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_rounded),
                      ),
                      Text(
                        selectedItems.isNotEmpty
                            ? selectedItems.length.toString() +
                                " Image Selected"
                            : 'No Image Selected',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return MyAlertDialog(
                                title: 'Warning !!!',
                                subTitle: 'Bạn có chắc chắn muốn xoá ?',
                                action: () {
                                  _deleteImages();
                                },
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void openImageGalleryView(images, index, BuildContext context) {
    Navigator.of(_scaffoldKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) => ImageView(
          images: images,
          currentIndex: index,
        ),
      ),
    );
  }

  void doMultiSelection(String imageId) {
    setState(() {
      if (selectedItems.contains(imageId)) {
        selectedItems.remove(imageId);
      } else {
        selectedItems.add(imageId);
      }
    });
    imageIds = selectedItems.toList();
  }

  void selectAndUploadImages(albumId, List<File> images) async {
    final List<XFile>? selectedImages = await _imagePicker.pickMultiImage();
    try {
      if (selectedImages!.isNotEmpty) {
        _imageFileList!.addAll(selectedImages);
      }
      _imageFileList?.forEach((xFile) {
        _imageFiles?.add(File(xFile.path));
      });
      ImagesProvider imagesProvider =
          Provider.of<ImagesProvider>(context, listen: false);
      await imagesProvider.uploadImagesToAlbum(albumId, images).then((value) {
        _imageFileList?.clear();
        _imageFiles?.clear();
      });
    } catch (e) {
      debugPrint(
          'Chưa có ảnh nào được chọn. (Null check operator used on a null value)');
    }
  }

  _deleteImages() {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    String imagesIdApi = '';

    if (imageIds.isNotEmpty) {
      for (var imageId in imageIds) {
        imagesIdApi = imagesIdApi + imageId + ",";
      }
    }

    imagesProvider
        .deleteImagesOfAlbum(imagesIdApi.substring(0, imagesIdApi.length - 1))
        .then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          loadingProvider.setLoading(false);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );
  }
}
