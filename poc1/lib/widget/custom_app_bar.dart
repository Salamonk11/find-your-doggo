import 'package:flutter/material.dart';
import 'package:poc1/utils/theme.dart';

/// Appbar custom
class CustomAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  /// Titolo dell'appbar
  final String title;

  @override
  final Size preferredSize;
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Palette.primary,
        title: Text(
          widget.title,
          style: Fonts.titleAppbar,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
    );
  }
}
