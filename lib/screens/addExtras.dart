import 'package:flutter/material.dart';
import '../models/readApi.dart';

class AddExtras extends StatefulWidget{

   RS events;
  int pos;

  AddExtras(this.events,this.pos);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddExtras(events,pos);
  }

}

class _AddExtras extends State<AddExtras> {

  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }

  RS events;
  int pos;
  int _radioValue = 0;

   int _currentIndex = 0;
  final List<Widget> _children = [Add(),View()];

_AddExtras(this.events,this.pos);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(events.name),
              centerTitle: true,
              elevation:0.0,
     ),
     body:_children[_currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped, // new
       currentIndex: _currentIndex, 
     // this will be set when a new tab is tapped
       items: [
         
         BottomNavigationBarItem(
           icon: new Icon(Icons.person_add,color:Theme.of(context).accentColor ,),
           title: new Text('Add',style: TextStyle(color: Theme.of(context).accentColor)),
           backgroundColor:Theme.of(context).accentColor
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.view_list,color:Theme.of(context).accentColor ,),
           title: new Text('View',style: TextStyle(color: Theme.of(context).accentColor),),
           
         ),
      
       ],
     ),
    );
  }
  
}

class Add extends  StatefulWidget{

   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Add();
  }
}

  
class _Add extends State<Add>{

   String gueName;
  String gueEmail;
  String guePhnNumber;
  String gueGender;
  String gueStake;
  String gueloc;

  
  List _gender =
  ["Male", "Female", "Other"];

  double _result = 0.0;
   String type;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
  
      switch (_radioValue) {
        case 0:
          _result = 1;
          type="Sponsers";
                   print(_result);
          break;
        case 1:
          _result = 2;
          type="Speakers";
          print(_result);
          break;
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _gender) {
      items.add(new DropdownMenuItem(
          value: gender,
          child: new Text(gender)
      ));
    }
    return items;
  }

   String newValue;

   int _radioValue = 0;

 @override
 Widget build(BuildContext context) {
   return Container(
     child: SingleChildScrollView(
                child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Container(
         child:
           Row(
             children: <Widget>[
              Flexible(child:Container(
                padding: EdgeInsets.all(16),
                child: Text("Sponsers"),),flex:10,)  , 
                       Flexible(child: Radio(
                         
        value: 0,
      
        groupValue: _radioValue,
        onChanged: _handleRadioValueChange,
      ),flex: 1,),
      Flexible(child:Container(
                padding: EdgeInsets.all(16),
                child: Text("Speakers"),),flex:10,)  , 
                       Flexible(child: Radio(
                         
        value: 1,
        groupValue: _radioValue,
        onChanged: _handleRadioValueChange,
      ),flex: 1,)
             ],
           ),),
          Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                 child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'About the event',
                  labelText: 'Name'
                ),
                 onSaved: (String val) {
            gueName= val;
           
          },
              )
              )),
              
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                 child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'About the event',
                  labelText: 'Email'
                ),
                 onSaved: (String val) {
            gueEmail= val;
           
          },
              )
              )),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                 child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'About the event',
                  labelText: 'Phone Number'
                ),
                 onSaved: (String val) {
            guePhnNumber= val;
           
          },
              )
              )),
              
        
        Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                 child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'About the event',
                  labelText: 'Stake'
                ),
              )
              )),
              Container(
                padding: EdgeInsets.only(left: 16.0,right:16.0,top: 16.0),
                 child: new Theme(
          data: new ThemeData(
            primaryColor: Theme.of(context).accentColor,
            
          ),
                child:
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //hintText: 'About the event',
                  labelText: 'Location Of Stay'
                ),
                 onSaved: (String val) {
           // gueloc= val;
           
          },
              )
              )),
              ListTile(
                
          title: const Text('Gender'),
          trailing: new DropdownButton<String>(
              hint: Text('Choose'),
              onChanged: (String changedValue) {
                newValue=changedValue;
                setState(() {
                  newValue;
                  gueGender=newValue;
                  print(newValue);
                });
              },
              value: newValue,
              items: <String>['Male', 'Female', 'Other']
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList()),
              ),
              Container(padding: EdgeInsets.all(16),
          child:
             new RaisedButton(
                elevation: 5,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                    child: Text('Submit',style: TextStyle(color: Colors.white),),
              onPressed: (){
//                _sendToServer();
               
              },))
       ],
     ),
     ),
   );
 }

 
}
class View extends  StatefulWidget{

   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _View();
  }
}

  
class _View extends State<View>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
              
          Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "View",
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
          child:Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),

            child: Center(
                child: Card(
                  elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new Container(
                              
                                padding: EdgeInsets.all(40.0),
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
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 15.0),
                                  child: Text(
                                    "Speakers",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 3.0),
                                  child: Text("Read, Edit and Delete",
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
                                  padding:
                                      EdgeInsets.only(left: 80.0, top: 10.0),
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    )),
                                  )),
                              flex: 23),
                        ]))),
            // size: Size(300, 100),
          ),
         // onTap: _json,
                    ),
                     GestureDetector(
          child:Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),

            child: Center(
                child: Card(
                  elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          new Flexible(
                            child: new Container(
                                padding: EdgeInsets.all(40.0),
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
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 15.0),
                                  child: Text(
                                    "Sponsors",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, top: 3.0),
                                  child: Text("Read, Edit and Delete",
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
                                  padding:
                                      EdgeInsets.only(left: 78.0, top: 10.0),
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    )),
                                  )),
                              flex: 23),
                        ]))),
            // size: Size(300, 100),
          ),
         // onTap: _excel,
                    ),
                  ],
                )
    );
    }

}