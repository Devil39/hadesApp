import 'package:flutter/material.dart';

const Color backgroundColor=Color(0xFFF7F7F7);
const Color bluegrey= Color(0xFF455A64);
const Color lightgrey=Color(0xFFFAFAFA);
const Color greyShadow= Color(0xFFE0E0E0);


const TextStyle introText=TextStyle(fontSize: 16.0,color:Colors.blue,fontWeight: FontWeight.w500,decoration: TextDecoration.none);
const TextStyle editText=TextStyle(fontSize: 16.0,color:Colors.blue,fontWeight: FontWeight.w500,decoration: TextDecoration.none);
const TextStyle loginformText=TextStyle(fontSize: 18.0,color:Colors.grey,fontWeight: FontWeight.w300,decoration: TextDecoration.none);
const TextStyle  blackNormalText=TextStyle(fontSize: 14.0,color:Colors.black,fontWeight: FontWeight.w300,decoration: TextDecoration.none);

const EdgeInsetsGeometry containerPad=EdgeInsets.all(8);
const EdgeInsetsGeometry containerMargin=EdgeInsets.all(16);



const Decoration continerDecor= BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: greyShadow,
        offset: Offset(0.5, 0.5),
        blurRadius: 10.0,
      ),
    ],
    shape: BoxShape.rectangle,
    color: lightgrey,
    borderRadius: BorderRadius.all(Radius.circular(10)));