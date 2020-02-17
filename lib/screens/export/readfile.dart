import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as prefix0;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/basic.dart' as prefix1;
import 'package:downloads_path_provider/downloads_path_provider.dart';  

import '../../models/readApi.dart';

class ReadFiles extends StatefulWidget {
  int pos;
  String title;
  ReadFiles(this.title, this.pos);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReadFiles(title, pos);
  }
}

class _ReadFiles extends State<ReadFiles> {
  @override
  void initState() {
    getAppDirectory();

    storage.readData(pos).then((String value) {
      setState(() {
        state = value;
      });
    });
    super.initState();
  }

  final pdf = prefix0.Document();
  Storage storage = Storage();

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  int pos;
  int _radioValue = 0;

  TextEditingController controller = TextEditingController();
  String state;
  Future<Directory> _appDocDir;

  String title;
  _ReadFiles(this.title, this.pos);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                FutureBuilder<Directory>(
                    future: _appDocDir,
                    builder: (BuildContext context,
                        AsyncSnapshot<Directory> snapshot) {
                      Text text = Text(
                        '',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      );
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          text = Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          text = Text('Path: ${snapshot.data.path}');
                        } else {
                          text = Text('Unavailable');
                        }
                      }
                      return new Container(
                        child: text,
                      );
                    }),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('${state ?? "Select the option"}'),
                ),
                Container(
                padding: EdgeInsets.all(16),
                child: new RaisedButton(
                  elevation: 5,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                  child: Text('Download as pdf',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    // print(state);
                    print("Download Started!");
                    pdf.addPage(prefix0.Page(
                    pageFormat: PdfPageFormat.a4,
                    build: (prefix0.Context context) {
                      return prefix0.Center(
                        child: prefix0.Text(
                          state
                        ),
                      ); // Center
                    })
                   );
                  //  final output = await getTemporaryDirectory();
                  //  Future<Directory> downloadsDirectory = DownloadsPathProvider.downloadsDirectory;
                  //  print(downloadsDirectory);
                  //  var path;
                  //  await downloadsDirectory.then((res){
                  //   //  print(res);
                  //    path=res;
                  //  });
                  // print(path.runtimeType);
                  // print(path.toString().split(": '")[1].replaceAll("'", ""));
                  // var path1=path.toString().split(": '")[1].replaceAll("'", "");
                  // final file = File("$path1/allParticipants.pdf");

                  final output=await getExternalStorageDirectory();
                  final file = File("${output.path}/allParticipants.pdf");
                  await file.writeAsBytes(pdf.save());
                  print("File Saved!");
                  print(output.path);
                  // print(path);
                  },
                )),
              ],
            ),
          ),
        ));
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<String> readData(int pos) async {
    try {
      // final file = await localFile;
      final path = await localPath;
      File file;
      if (pos == 1) {
        file = File('$path/All_Participants.txt');
      } else if (pos == 2) {
        file = File('$path/Present_Participants.txt');
      } else if (pos == 3) {
        file = File('$path/Absent_Participants.txt');
      }

      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data, int pos) async {
    final path = await localPath;
    File file;
    if (pos == 1) {
      file = File('$path/All_Participants.txt');
    } else if (pos == 2) {
      file = File('$path/Present_Participants.txt');
    } else if (pos == 3) {
      file = File('$path/Absent_Participants.txt');
    }

    return file.writeAsString("$data");
  }
}
