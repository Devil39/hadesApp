import 'package:flutter/material.dart';

import '../../../ui_utils/colors.dart';
import '../../../ui_utils/widgets/app_bar.dart';

class AttendanceDaySelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: BColors.blue,
              ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: 'WomenTechies',
      ),
      body: Container(
        child: Center(
          child: Text("Select Day"),
        ),
      ),
    );
  }
}
