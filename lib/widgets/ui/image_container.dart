import 'package:flutter/material.dart';

// >> Refactor image card to use this (JK)

class ImageContainer extends StatelessWidget {
  final double size;
  final String imagePath;
  ImageContainer(this.size, this.imagePath);

  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
