import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key key,
    @required this.headingText,
    this.headingFollowText = null,
    this.headingFollowWidget = null,
    this.headingTextSize = Dimens.headingTextSize,
    this.headingTextColor = BColors.black,
  }) : super(key: key);

  final String headingText, headingFollowText;
  final double headingTextSize;
  final Widget headingFollowWidget;
  final Color headingTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 27.0,
        vertical: 12.0,
      ),
      child: Row(
        children: [
          Text(
            headingText,
            style: TextStyle(
              fontSize: headingTextSize,
              color: headingTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          headingFollowText != null
              ? Text(
                  headingFollowText,
                  style: TextStyle(
                    fontSize: headingTextSize,
                    color: BColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : headingFollowWidget ?? Container()
        ],
      ),
    );
  }
}
