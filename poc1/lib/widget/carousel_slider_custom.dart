import 'dart:async';

import 'package:flutter/material.dart';

/// Carosello che scorre in automatico gli [items] in maniera circolare
class CustomCarouselSlider extends StatefulWidget {
  /// Carosello che scorre in automatico gli [items] in maniera circolare
  const CustomCarouselSlider({
    required this.items,
    this.onPageChanged,
    super.key,
  });

  /// Funzione che viene chiamata quando la pagina cambia [items]
  // ignore: inference_failure_on_function_return_type
  final Function(int index)? onPageChanged;

  /// Items che vengono visualizzati nel carosello (url)
  final List<String> items;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  Timer? timer;

  final PageController _pageController = PageController(initialPage: 4000);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        _currentIndex = index % widget.items.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  end: Alignment.bottomCenter,
                  begin: Alignment.center,
                ),
              ),
              child: Image.network(
                widget.items[_currentIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
      onPageChanged: (value) {
        _currentIndex = value % widget.items.length;

        widget.onPageChanged?.call(_currentIndex);
      },
      controller: _pageController,
    );
  }
}
