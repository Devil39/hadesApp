import 'package:flutter/material.dart';

import '../colors.dart';
import '../dimens.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    @required this.onChanged,
    @required this.value,
    @required this.itemsList,
    @required this.title,
  });

  final Function onChanged;
  final String value, title;
  final List<String> itemsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(title),
        trailing: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: BColors.blue,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              color: BColors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: DropdownButton<String>(
                  underline: Container(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: BColors.white,
                ),
                iconSize: Dimens.buttonTextSize,
                hint: Text(
                  'Choose',
                  style: TextStyle(
                    color: BColors.white,
                    fontSize: Dimens.buttonTextSize,
                  ),
                ),
                onChanged: onChanged,
                value: value,
                items: itemsList.map(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: BColors.white,
                          fontSize: Dimens.buttonTextSize,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
