import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc1/connection/connection.dart';
import 'package:poc1/widget/custom_button.dart';

class SubreedSectionItem extends StatefulWidget {
  const SubreedSectionItem({
    Key? key,
    required this.subbreedName,
    required this.breedName,
    required this.scrollController,
  }) : super(key: key);

  final String breedName;
  final String subbreedName;
  final ScrollController scrollController;

  @override
  State<SubreedSectionItem> createState() => _SubreedSectionItemState();
}

class _SubreedSectionItemState extends State<SubreedSectionItem> {
  final _images = ValueNotifier<List<String>>([]);
  final _connection = Connection();

  @override
  void initState() {
    super.initState();
    _getImagesSubbreed();
  }

  Future<void> _getImagesSubbreed() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _images.value = (await _connection.getRandomImageBySubbreed(
            breed: widget.breedName,
            subreed: widget.subbreedName,
            definedNum: 4,
          )) ??
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: _images.value.length,
                itemBuilder: (context, index) {
                  final card = _images.value[index];
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RepaintBoundary(
                      key: const Key('Image card breed'),
                      child: Image.network(
                        card,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                addAutomaticKeepAlives: false,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomButton(
                onPressed: () async => _images.value =
                    (await _connection.getRandomImageBySubbreed(
                        subreed: widget.subbreedName,
                        breed: widget.breedName,
                        definedNum: 4)) ?? [],
                text: 'Generate random ${widget.subbreedName}',
              ),
            ),
          ],
        );
      },
    );
  }
}
