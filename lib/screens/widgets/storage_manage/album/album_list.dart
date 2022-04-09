import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/providers/album_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/album/images/image_list.dart';
import 'package:provider/provider.dart';

import 'album_card.dart';

class AlbumList extends StatefulWidget {
  final List<Album> albums;

  const AlbumList({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(builder: ((context, albumProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.builder(
          itemCount: widget.albums.length,
          itemBuilder: (context, index) {
            Album album = widget.albums[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ImageList(album: album),
                            ),
                          );
                        },
                        child: AlbumCard(album: album),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }));
  }
}
