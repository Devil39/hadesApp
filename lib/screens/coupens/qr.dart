// import 'package:flutter/material.dart';
// import 'package:qrcode/qrcode.dart';
// import 'package:permission_handler/permission_handler.dart';

// class QR extends StatefulWidget {
//   @override
//   _QRState createState() => _QRState();
// }

// class _QRState extends State<QR> {
//    QRCaptureController _captureController = QRCaptureController();

//   bool _isTorchOn = false;

//   @override
//   void initState() {
//     super.initState();
//     initializePage();
//   }

//   void initializePage() async {
//     Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
//     PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
//     if(permission==PermissionStatus.denied)
//      {
//        bool isOpened = await PermissionHandler().openAppSettings();
//      }
//     print(permission);
//     _captureController.onCapture((data) {
//       print('onCapture----$data');
//     });
//     // var permissions = await Permission.getPermissionsStatus([PermissionName.Camera]);
//     // var permissionNames = await Permission.requestPermissions([PermissionName.Camera]);
//     // Permission.openSettings;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             QRCaptureView(controller: _captureController),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: _buildToolBar(),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildToolBar() {
//     return Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 _captureController.pause();
//               },
//               child: Text('pause'),
//             ),
//             FlatButton(
//               onPressed: () {
//                 if (_isTorchOn) {
//                   _captureController.torchMode = CaptureTorchMode.off;
//                 } else {
//                   _captureController.torchMode = CaptureTorchMode.on;
//                 }
//                 _isTorchOn = !_isTorchOn;
//               },
//               child: Text('torch'),
//             ),
//             FlatButton(
//               onPressed: () {
//                 _captureController.resume();
//               },
//               child: Text('resume'),
//             ),
//           ],
//         );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

// void main() => runApp(MaterialApp(home: QRViewExample()));

// const flash_on = "FLASH ON";
// const flash_off = "FLASH OFF";
// const front_camera = "FRONT CAMERA";
// const back_camera = "BACK CAMERA";

// class QRViewExample extends StatefulWidget {
//   const QRViewExample({
//     Key key,
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   var qrText = "";
//   var flashState = flash_on;
//   var cameraState = front_camera;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//               overlay: QrScannerOverlayShape(
//                 borderColor: Colors.red,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: 300,
//               ),
//             ),
//             flex: 4,
//           ),
//           Expanded(
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Text("This is the result of scan: $qrText"),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.all(8.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             if (controller != null) {
//                               controller.toggleFlash();
//                               if (_isFlashOn(flashState)) {
//                                 setState(() {
//                                   flashState = flash_off;
//                                 });
//                               } else {
//                                 setState(() {
//                                   flashState = flash_on;
//                                 });
//                               }
//                             }
//                           },
//                           child:
//                               Text(flashState, style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.all(8.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             if (controller != null) {
//                               controller.flipCamera();
//                               if (_isBackCamera(cameraState)) {
//                                 setState(() {
//                                   cameraState = front_camera;
//                                 });
//                               } else {
//                                 setState(() {
//                                   cameraState = back_camera;
//                                 });
//                               }
//                             }
//                           },
//                           child:
//                               Text(cameraState, style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.all(8.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             controller?.pauseCamera();
//                           },
//                           child: Text('pause', style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.all(8.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             controller?.resumeCamera();
//                           },
//                           child: Text('resume', style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             flex: 1,
//           )
//         ],
//       ),
//     );
//   }

//   _isFlashOn(String current) {
//     return flash_on == current;
//   }

//   _isBackCamera(String current) {
//     return back_camera == current;
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }