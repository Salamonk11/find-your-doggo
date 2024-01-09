import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:poc1/connection/connection.dart';
import 'package:poc1/model/breed.dart';
import 'package:poc1/pages/breed_section.dart';
import 'package:poc1/widget/breed_card.dart';

/// Home page con la lista delle razze
class HomePage extends StatefulWidget {
  /// Home page con la lista delle razze
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connection _connection = Connection();
  // lista delle razze
  final _listBreed = ValueNotifier(<Breed>[]);

  @override
  void initState() {
    super.initState();
    _getImagesSubbreed();
  }

  /// Scarica la lista di tutte le razze
  Future<void> _getImagesSubbreed() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _listBreed.value = await _connection.getAllBreeds() ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ValueListenableBuilder<List<Breed>>(
          valueListenable: _listBreed,
          builder: (context, snapshot, _) {
            if (snapshot.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.length,
              itemBuilder: (context, index) {
                final breed = snapshot[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BreedSection(
                        breed: breed,
                      ),
                    ),
                  ),
                  child: BreedCard(
                    key: const Key('card'),
                    breed: breed,
                    onCardEntered: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BreedSection(
                          breed: breed,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
