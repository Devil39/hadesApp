import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// import 'package:qrcode_reader/qrcode_reader.dart' as prefix0;
// import 'package:permission/permission.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:barcode_scan/barcode_scan.dart';

class QrCodeReader extends StatefulWidget {

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  _QrCodeReaderState createState() => _QrCodeReaderState();
}

class _QrCodeReaderState extends State<QrCodeReader> {
  Future<String> _barcodeString;

  @override
  void initState(){
    super.initState();
    initializePage();
  }

  void initializePage() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if(permission==PermissionStatus.denied)
     {
       bool isOpened = await PermissionHandler().openAppSettings();
     }
    print(permission);
    // var permissions = await Permission.getPermissionsStatus([PermissionName.Camera]);
    // var permissionNames = await Permission.requestPermissions([PermissionName.Camera]);
    // Permission.openSettings;
  }

  String barcode = "";

  Widget _buildSideDrawer(){
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.orange,
              height: 210,
            ),
            GestureDetector(
              onTap: (){
                //   Navigator.push(context, MaterialPageRoute(
                //     builder: (BuildContext context)=>FloorPlan()
                //   )
                // );
              },
              child: ListTile(
                title: Text(
                  "Floor Plan",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ),
            Divider(
              height: 10,
              color: Colors.red,
            ),
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (BuildContext context)=>MyHomePage()
              //   )
              // );
            },
            child: ListTile(
                title: Text(
                  "Navigate",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
          ),
            Divider(
              height: 10,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Widget _buildFloatingActionButton(){
    return FloatingActionButton(
      onPressed: () async {
        print("Pressed!");
        print("Starting to scan!");
        /*String scanResult=await scanner.scan();
        print(scanResult);*/
        await scan();                              
        print(barcode);
        // print(barcodeString);
        // barcodeString.then((res){
        //   print(res);
        // setState(() {
        // setState(() {
        //   // _barcodeString = new prefix0.QRCodeReader()
        //   //     .setAutoFocusIntervalInMs(200)
        //   //     .setForceAutoFocus(true)
        //   //     .setTorchEnabled(true)
        //   //     .setHandlePermissions(true)
        //   //     .setExecuteAfterPermissionGranted(true)
        //   //     //.setFrontCamera(false)
        //   //     .scan();
        //   //     print("here!");
        //   // _barcodeString=scanResult;
        // });
        // print("Scanning done!");
      },
      tooltip: 'Reader the QrCode',
      child: new Icon(Icons.add_a_photo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _buildSideDrawer(),
      appBar: new AppBar(
        title: const Text('QrCode Reader Example'),
      ),
      body: Container(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                // return ContentPage(snapshot);
                // print();
                return Text(snapshot.data.toString());
              })),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
      
  //   );
  // }
}

// MyHomePage({Key key, this.title}) : super(key: key);

// final title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Future<String> _barcodeString;

//   Widget _buildSideDrawer(){
//     return Drawer(
//       child: Container(
//         child: ListView(
//           children: <Widget>[
//             Container(
//               color: Colors.orange,
//               height: 210,
//             ),
//             GestureDetector(
//               onTap: (){
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (BuildContext context)=>FloorPlan()
//                   )
//                 );
//               },
//               child: ListTile(
//                 title: Text(
//                   "Floor Plan",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 18
//                   ),
//                 ),
//               ),
//             ),
//             Divider(
//               height: 10,
//               color: Colors.red,
//             ),
//           GestureDetector(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                   builder: (BuildContext context)=>MyHomePage()
//                 )
//               );
//             },
//             child: ListTile(
//                 title: Text(
//                   "Navigate",
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                     fontSize: 18
//                   ),
//                 ),
//               ),
//           ),
//             Divider(
//               height: 10,
//               color: Colors.red,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFloatingActionButton(){
//     return FloatingActionButton(
//       onPressed: () {
//         setState(() {
//           _barcodeString = new QrCodeReader()
//               .setAutoFocusIntervalInMs(200)
//               .setForceAutoFocus(true)
//               .setTorchEnabled(true)
//               .setHandlePermissions(true)
//               .setExecuteAfterPermissionGranted(true)
//               //.setFrontCamera(false)
//               .scan();
//         });
//       },
//       tooltip: 'Reader the QrCode',
//       child: new Icon(Icons.add_a_photo),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       drawer: _buildSideDrawer(),
//       appBar: new AppBar(
//         title: const Text('QrCode Reader Example'),
//       ),
//       body: Container(
//           child: new FutureBuilder<String>(
//               future: _barcodeString,
//               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                 return ContentPage(snapshot);
//               })),
//       floatingActionButton: _buildFloatingActionButton(),
//     );
//   }