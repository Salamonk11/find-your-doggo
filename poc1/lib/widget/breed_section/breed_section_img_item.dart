import 'package:flutter/material.dart';

/// Item dell'img di una razza
class BreedSectionImgItem extends StatefulWidget {
  /// Item dell'img di una razza

  const BreedSectionImgItem(
      {super.key, required this.imgUrl, required this.index});

  final String imgUrl;

  final int index;

  @override
  State<BreedSectionImgItem> createState() => _BreedSectionImgItemState();
}

class _BreedSectionImgItemState extends State<BreedSectionImgItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.network(
          widget.imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
