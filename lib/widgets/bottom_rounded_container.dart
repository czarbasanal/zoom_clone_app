import 'package:flutter/material.dart';

class BottomRoundedContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double borderRadius;

  const BottomRoundedContainer({
    Key? key,
    this.height = 200.0,
    this.width = double.infinity,
    this.color = Colors.white,
    this.borderRadius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
