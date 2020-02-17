import 'package:flutter/material.dart';
import '../../models/readApi.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ReadFiles extends StatefulWidget{

 
  int pos;
String title;
  ReadFiles(this.title,this.pos);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReadFiles(title,pos);
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

   Storage storage=Storage();
  
 

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
_ReadFiles(this.title,this.pos);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return 
         Scaffold(
      appBar: AppBar(
        
        title: Text(title,textAlign: TextAlign.center,),
       centerTitle: true,
       elevation: 0.0,
      ),
      body:SingleChildScrollView(child: Container(
        child: Column(
          children: <Widget>[

            FutureBuilder<Directory>(
              future: _appDocDir,
              builder:
                  (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                Text text = Text('',style: TextStyle(fontWeight: FontWeight.w600),);
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    text = Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    text = Text('Path: ${snapshot.data.path}',style: TextStyle(fontWeight: FontWeight.w500),);
                  } else {
                    text = Text('Unavailable');
                  }
} return new Container(
                  child: text,
);
                  }
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child:  Text('${state ?? "Select the option"}'),
              )
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



  Future<String> readData(int pos ) async {
    try {
     // final file = await localFile;
     final path = await localPath;
    File file;
    if(pos==0){
    file =  File('$path/All_Participantsexcel.txt');
    }
    else if(pos==1){
    file =  File('$path/Present_Participantsexcel.txt');
    }
     else if(pos==2){
     file =  File('$path/Absent_Participantsexcel.txt');
    }
    
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data,int pos) async {
    final path = await localPath;
    File file;
    if(pos==1){
    file =  File('$path/All_Participantsexcel.txt');
    }
    else if(pos==2){
    file =  File('$path/Present_Participantsexcel.txt');
    }
     else if(pos==3){
     file =  File('$path/Absent_Participantsexcel.txt');
    }
    
  
    
     
    return file.writeAsString("$data");
  
  }


}
 
 
 