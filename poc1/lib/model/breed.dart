import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed.freezed.dart';
part 'breed.g.dart';

/// Model della razza
@freezed
class Breed with _$Breed {
  const factory Breed({
    required String name,
    @Default([]) List<String> subBreeds,
  }) = _Breed;

  factory Breed.fromJson(Map<String, dynamic> json) => _Breed.fromJson(json);
}
