import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class Header extends StatelessWidget with PreferredSizeWidget{

  Header({@required this.title, @required this.leading, this.titleSize = Dimens.appBarTextSize, this.actionsList = const <Widget>[]});

  final String title;
  final Widget leading;
  final double titleSize;
  final List<Widget> actionsList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: BColors.transparent,
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleSize,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      leading: leading,
      actions: actionsList,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.appBarHeight);
}
