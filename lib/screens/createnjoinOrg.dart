import 'package:flutter/material.dart';
class CreatenJoinOrg extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return CreateJoinOrgState();
  }

}

class CreateJoinOrgState extends State<CreatenJoinOrg>{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
            child:Text("Create")
          ),
           Container(
            child:Text("Join")
          )
        ],),
      ),
    );
  }

}