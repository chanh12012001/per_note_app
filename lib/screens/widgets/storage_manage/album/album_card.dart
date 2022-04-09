import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/models/image_model.dart';
import 'package:per_note/providers/album_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/album/detail_album_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import 'package:per_note/services/toast_service.dart';
import '../../../../providers/image_provider.dart';
import '../../../../providers/loading_provider.dart';
import '../../alert_dialog.dart';

class AlbumCard extends StatefulWidget {
  final Album album;
  const AlbumCard({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<AlbumCard> createState() => _AlbumCardState();
}

class _AlbumCardState extends State<AlbumCard> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return MyAlertDialog(
                    title: 'Warning !!!',
                    subTitle: 'Bạn có chắc chắn muốn xoá ?',
                    action: () {
                      _deleteAlbum(widget.album);
                    },
                  );
                },
              );
            },
            backgroundColor: redColor!,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Xoá',
          ),
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  return DetailAlbumDialog(album: widget.album);
                },
              );
            },
            backgroundColor: blueColor!,
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Chỉnh sửa',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              FutureBuilder<String?>(
                future: _getFirstImageByAlbumId(widget.album.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return snapshot.hasData
                      ? _buildImageAlbumBackground(
                          NetworkImage(
                            snapshot.data!,
                          ),
                        )
                      : _buildImageAlbumBackground(
                          const AssetImage(
                            'assets/images/photo_gallery.png',
                          ),
                        );
                },
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.album.name!,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder<int>(
                      future: _getQualityImageByAlbumId(widget.album.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return snapshot.hasData
                            ? Text(
                                snapshot.data.toString() + " ảnh",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              )
                            : const Text('Đang tải');
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _deleteAlbum(Album album) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    AlbumProvider albumProvider =
        Provider.of<AlbumProvider>(context, listen: false);
    albumProvider.deleteAlbum(album).then(
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

  Widget _buildImageAlbumBackground(ImageProvider image) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: kElevationToShadow[3],
      ),
    );
  }

  Future<int> _getQualityImageByAlbumId(albumId) async {
    ImagesProvider _imageProvider = Provider.of<ImagesProvider>(context);
    List<ImageModel> images =
        await _imageProvider.getAllImagesByAlbumId(albumId);
    return images.length;
  }

  Future<String?> _getFirstImageByAlbumId(albumId) async {
    ImagesProvider _imageProvider = Provider.of<ImagesProvider>(context);
    String imagePhotoGallery =
        "https://res.cloudinary.com/chanhpham/image/upload/v1648918401/per-note/photo_gallery_agkbwk.jpg";
    List<ImageModel> images =
        await _imageProvider.getAllImagesByAlbumId(albumId);
    if (images.isNotEmpty) {
      return images[0].imageUrl;
    }
    return imagePhotoGallery;
  }
}
