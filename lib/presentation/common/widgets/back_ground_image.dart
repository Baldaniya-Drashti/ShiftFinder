import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BackGroundImage extends StatelessWidget {
  Widget? child;
  String imageString;
  BackGroundImage({super.key, this.child, required this.imageString});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imageString),
        if (child != null) child!,
      ],
    );
  }
}
