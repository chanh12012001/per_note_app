import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:per_note/models/note_model.dart';
import '../../../../config/theme.dart';
import 'package:per_note/services/toast_service.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 135.0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: greyColor!, width: 1.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.note.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: itemTitle,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _getFormatedDate(widget.note.createdAt),
                      overflow: TextOverflow.ellipsis,
                      style: itemDateStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        widget.note.content!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: itemContentStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.note.imageUrl != ''
                ? Row(
                    children: [
                      const SizedBox(
                        width: 12.0,
                      ),
                      Container(
                        width: 80.0,
                        height: 95.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.note.imageUrl!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  _getFormatedDate(_date) {
    final format = DateFormat('yyyy-MM-ddTHH:mm:ssZ', 'en-US');
    var inputDate = format.parse(_date);

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    return outputFormat.format(inputDate);
  }

  // _deleteAlbum(Album album) {
  //   LoadingProvider loadingProvider =
  //       Provider.of<LoadingProvider>(context, listen: false);
  //   AlbumProvider albumProvider =
  //       Provider.of<AlbumProvider>(context, listen: false);
  //   albumProvider.deleteAlbum(album).then(
  //     (response) {
  //       if (response['status']) {
  //         Navigator.pop(context);
  //         loadingProvider.setLoading(false);
  //         toast.showToast(
  //           context: context,
  //           message: response['message'],
  //           icon: Icons.error,
  //           backgroundColor: Colors.green,
  //         );
  //       } else {
  //         toast.showToast(
  //           context: context,
  //           message: response['message'],
  //           icon: Icons.error,
  //           backgroundColor: Colors.redAccent,
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget _buildImageAlbumBackground(ImageProvider image) {
  //   return Container(
  //     width: 150,
  //     height: 100,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: image,
  //         fit: BoxFit.fill,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //       boxShadow: kElevationToShadow[3],
  //     ),
  //   );
  // }

  // Future<int> _getQualityImageByAlbumId(albumId) async {
  //   ImagesProvider _imageProvider = Provider.of<ImagesProvider>(context);
  //   List<ImageModel> images =
  //       await _imageProvider.getAllImagesByAlbumId(albumId);
  //   return images.length;
  // }

  // Future<String?> _getFirstImageByAlbumId(albumId) async {
  //   ImagesProvider _imageProvider = Provider.of<ImagesProvider>(context);
  //   String imagePhotoGallery =
  //       "https://res.cloudinary.com/chanhpham/image/upload/v1648918401/per-note/photo_gallery_agkbwk.jpg";
  //   List<ImageModel> images =
  //       await _imageProvider.getAllImagesByAlbumId(albumId);
  //   if (images.isNotEmpty) {
  //     return images[0].imageUrl;
  //   }
  //   return imagePhotoGallery;
  // }
}
