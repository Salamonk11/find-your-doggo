import 'package:flutter/material.dart';
import 'package:poc1/model/breed.dart';
import 'package:poc1/utils/theme.dart';
import 'package:poc1/widget/breed_section/breed_section_image.dart';
import 'package:poc1/widget/breed_section/subreed_section_item.dart';
import 'package:poc1/widget/custom_app_bar.dart';

/// Sezione della razza
class BreedSection extends StatefulWidget {
  /// Sezione della razza
  const BreedSection({super.key, required this.breed});

  /// Razza da mostrare
  final Breed breed;

  @override
  State<BreedSection> createState() => _BreedSectionState();
}

class _BreedSectionState extends State<BreedSection> {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: CustomAppbar(title: widget.breed.name),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomScrollView(controller: _controller, slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              sliver: SliverToBoxAdapter(
                  child: BreedSectionImg(
                breed: widget.breed,
              )),
            ),
            if (widget.breed.subBreeds.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Subbreeds',
                      style: Fonts.titleSection,
                    ),
                  ),
                ),
              ),
            for (var subreed in widget.breed.subBreeds)
              SliverPadding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${widget.breed.name} $subreed',
                              style: Fonts.titleCard,
                            ),
                            const Spacer(),
                            Text(
                              '${widget.breed.subBreeds.indexOf(subreed) + 1} di ${widget.breed.subBreeds.length}',
                              style: Fonts.infoSubbreeds,
                            ),
                          ],
                        ),
                      ),
                      SubreedSectionItem(
                        subbreedName: subreed,
                        breedName: widget.breed.name,
                        scrollController: _controller,
                      ),
                    ],
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
