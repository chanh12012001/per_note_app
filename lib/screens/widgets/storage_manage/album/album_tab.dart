import 'package:flutter/material.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/screens/widgets/storage_manage/album/detail_album_dialog.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import '../../../../providers/album_provider.dart';
import 'album_list.dart';
import 'package:per_note/services/toast_service.dart';

class AlbumTab extends StatefulWidget {
  const AlbumTab({Key? key}) : super(key: key);

  @override
  State<AlbumTab> createState() => _AlbumTabState();
}

class _AlbumTabState extends State<AlbumTab> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const DetailAlbumDialog();
            },
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_box),
      ),
      body: _showAlbums(),
    );
  }

  _showAlbums() {
    AlbumProvider albumProvider =
        Provider.of<AlbumProvider>(context, listen: false);

    return FutureBuilder<List<Album>>(
      future: albumProvider.getAlbumsList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return snapshot.hasData
            ? AlbumList(albums: snapshot.data!)
            : const Center(
                child: ColorLoader(),
              );
      },
    );
  }
}
