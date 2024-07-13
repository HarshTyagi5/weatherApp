
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  String image;
  double scale;
  ImageWidget(this.image,this.scale,{super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(image,scale: scale,);
  }
}
