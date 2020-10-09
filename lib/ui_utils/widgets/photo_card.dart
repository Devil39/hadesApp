import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({
    @required this.tileTitle,
    @required this.tileImage,
    @required this.tileTrailing,
    this.tileSubtitle = '',
    this.onPressed,
    this.bgColor,
    this.icon,
  });

  final String tileTitle, tileImage, tileSubtitle;
  final Widget tileTrailing;
  final Function onPressed;
  final Color bgColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor == null ? BColors.backgroundBlue : bgColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 9.0,
        ),
        padding: EdgeInsets.all(10.0),
        child: ListTile(
          title: Text(
            tileTitle,
            style: TextStyle(
              fontSize: Dimens.tileTitleTextSize,
            ),
          ),
          subtitle: Text(tileSubtitle),
          leading: icon != null
              ? icon
              : Container(
                  width: 60.0,
                  height: 69.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(tileImage),
                    ),
                  ),
                ),
          trailing: tileTrailing,
        ),
      ),
    );
  }
}
