import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc1/connection/connection.dart';
import 'package:poc1/model/breed.dart';
import 'package:poc1/widget/breed_section/breed_section_img_item.dart';
import 'package:poc1/widget/custom_button.dart';

/// Immagini della razza nelle sezioni
class BreedSectionImg extends StatefulWidget {
  const BreedSectionImg({
    super.key,
    required this.breed,
  });

  /// razza di cui scaricare le img
  final Breed breed;

  @override
  State<BreedSectionImg> createState() => _BreedSectionImgState();
}

class _BreedSectionImgState extends State<BreedSectionImg> {
  final _connection = Connection();
  final _images = ValueNotifier(<String>[]);

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  Future<void> _getImages() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _images.value = (await _connection.getRandomImageByBreed(
              breed: widget.breed, definedNum: 2)) ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _images,
      builder: (context, value, _) {
        if (value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sezione razza
            ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BreedSectionImgItem(
                  imgUrl: value[index],
                  index: index,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomButton(
                onPressed: () async => {
                  _images.value = (await _connection.getRandomImageByBreed(
                      breed: widget.breed, definedNum: 2))!
                },
                text: 'Generate random ${widget.breed.name}',
              ),
            ),
          ],
        );
      },
    );
  }
}
