import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  Color color;
  String text;
  FontWeight fontWeight;
  TextWidget(this.color, this.text, this.fontWeight, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color,fontWeight: fontWeight),
    );
  }
}
