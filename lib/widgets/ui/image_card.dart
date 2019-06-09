import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final double size;
  final String imagePath;
  ImageCard(this.size, this.imagePath);

  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(imagePath),
            ),
          ),
        ),
      ),
    );
  }
}
