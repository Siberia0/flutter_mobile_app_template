import 'package:flutter/material.dart';

import '../../const/app_color.dart';

class CommonElevatedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final Color backgroundColor;
  final Color fontColor;
  final double borderRadius;
  final double elevation;
  final double verticalTextPadding;

  const CommonElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor = AppColor.primary,
    this.fontColor = Colors.white,
    this.borderRadius = 28.0,
    this.elevation = 3.0,
    this.verticalTextPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadowColor: Colors.black,
        elevation: elevation,
        padding: EdgeInsets.symmetric(
            vertical: verticalTextPadding, horizontal: 10.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: fontColor,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
