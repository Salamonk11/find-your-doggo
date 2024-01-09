import 'package:flutter/material.dart';
import 'package:poc1/utils/theme.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function()? onPressed;

  final String text;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.secondary,
      ),
      onPressed: () async =>
          widget.onPressed != null ? widget.onPressed!() : null,
      child: Text(
        widget.text,
        style: Fonts.textPrimaryButton,
      ),
    );
  }
}
