import 'package:flutter/material.dart';

import 'package:hades_app/models/readApi1.dart';
import '../../models/readApi.dart';
import '../../screens/export/readfile.dart';

class Files extends StatefulWidget {
  RS1 events;
  int pos;

  Files(this.events, this.pos);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Files(events, pos);
  }
}

class _Files extends State<Files> {
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  RS1 events;
  int pos;
  int _radioValue = 0;

  int _currentIndex = 0;

  _Files(this.events, this.pos);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Json Files",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Files",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    IconButton(
                        icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )),
                  ],
                )),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

                child: Center(
                    child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Container(
                                    child: Icon(Icons.folder_shared, size: 40),
                                    padding: EdgeInsets.all(20.0),
                                    decoration: new BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0)))),
                                flex: 18,
                              ),
                              new Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, top: 15.0),
                                      child: Text(
                                        "All Participants",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 3.0),
                                      child: Text("Json",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0,
                                              color: Colors.grey)),
                                    )
                                  ],
                                ),
                                flex: 30,
                              ),
                              Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 78.0, top: 10.0),
                                      child: Center(
                                        child: IconButton(
                                            icon: Icon(
                                          Icons.chevron_right,
                                        )),
                                      )),
                                  flex: 23),
                            ]))),
                // size: Size(300, 100),
              ),
              //   onTap: _excel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReadFiles("All Participants", 1)),
                );
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),

                child: Center(
                    child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Container(
                                    child: Icon(Icons.folder_shared, size: 40),
                                    padding: EdgeInsets.all(20.0),
                                    decoration: new BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0)))),
                                flex: 28,
                              ),
                              new Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, top: 15.0),
                                      child: Text(
                                        "Present Participants",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 3.0),
                                      child: Text("Json",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0,
                                              color: Colors.grey)),
                                    )
                                  ],
                                ),
                                flex: 35,
                              ),
                              Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 78.0, top: 10.0),
                                      child: Center(
                                        child: IconButton(
                                            icon: Icon(
                                          Icons.chevron_right,
                                        )),
                                      )),
                                  flex: 43),
                            ]))),
                // size: Size(300, 100),
              ),
              //   onTap: _excel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadFiles("Present Participants", 2)),
                );
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),

                child: Center(
                    child: Card(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new Container(
                                    child: Icon(Icons.folder_shared, size: 40),
                                    padding: EdgeInsets.all(20.0),
                                    decoration: new BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15.0),
                                            topLeft: Radius.circular(15.0)))),
                                flex: 28,
                              ),
                              new Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, top: 15.0),
                                      child: Text(
                                        "Absent Participants",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 3.0),
                                      child: Text("Json",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0,
                                              color: Colors.grey)),
                                    )
                                  ],
                                ),
                                flex: 30,
                              ),
                              Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 78.0, top: 10.0),
                                      child: Center(
                                        child: IconButton(
                                            icon: Icon(
                                          Icons.chevron_right,
                                        )),
                                      )),
                                  flex: 43),
                            ]))),
                // size: Size(300, 100),
              ),
              //   onTap: _excel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ReadFiles("Absent Participants", 3)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
