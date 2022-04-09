import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:per_note/models/image_model.dart';

class ImageCard extends StatelessWidget {
  final ImageModel image;
  final bool isSelected;
  final HashSet selectedItems;
  const ImageCard({
    Key? key,
    required this.image,
    this.isSelected = false,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image.imageUrl!),
                colorFilter: ColorFilter.mode(
                    Colors.black
                        .withOpacity(selectedItems.contains(image.id) ? 1 : 0),
                    BlendMode.color),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Visibility(
          visible: selectedItems.contains(image.id),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
