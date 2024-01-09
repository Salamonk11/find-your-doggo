import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc1/connection/connection.dart';
import 'package:poc1/model/breed.dart';
import 'package:poc1/utils/theme.dart';
import 'package:poc1/widget/carousel_slider_custom.dart';

/// Card della razza
class BreedCard extends StatefulWidget {
  /// Card della razza
  const BreedCard(
      {super.key, required this.breed, required this.onCardEntered});

  final Breed breed;

  final void Function() onCardEntered;

  @override
  State<BreedCard> createState() => _BreedCardState();
}

class _BreedCardState extends State<BreedCard> {
  final Connection _connection = Connection();
  final _images = ValueNotifier<List<String>>([]);

  /// Indica l'items corrente all'interno del [CustomCarouselSlider]
  final _currentImg = ValueNotifier<int>(0);


  @override
  void initState() {
    super.initState();
    _getImagesSubbreed();
  }

  /// Scarica le immagini di una breed
  Future<void> _getImagesSubbreed() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _images.value = (await _connection.getRandomImageByBreed(
            breed: widget.breed,
            definedNum: 3,
          )) ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: _images,
              builder: (context, snap, _) {
                if (snap.isEmpty) return Container();
                final images = snap;
                return Flexible(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomCarouselSlider(
                        items: images,
                        onPageChanged: (index) => _currentImg.value = index,
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _currentImg,
                        builder: (context, currentIndex, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (int i = 0; i < images.length; i++)
                                Container(
                                  height: 10,
                                  width: 10,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: _currentImg.value == i
                                        ? Palette.primary
                                        : Palette.background,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  widget.breed.name,
                  style: Fonts.titleCard,
                ),
                const Spacer(),
                if (widget.breed.subBreeds.isNotEmpty)
                  Text(
                    '${widget.breed.subBreeds.length} subbreed',
                    style: Fonts.infoSubbreedsCard,
                  ),
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: Palette.text,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
