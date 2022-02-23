import 'package:flutter/material.dart';


/*
控制TextField_decoration樣式
 */

class TextFieldDecoration{
  InputDecoration textInputDecoration([String labelText='' , String hintText='',int choice_IncomePay=0]){
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      //點選輸入時顏色變換
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: ColoerPicker(choice_IncomePay)[0])),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide(color: ColoerPicker(choice_IncomePay)[1])),
    );
  }
  ColoerPicker(int choice_IncomePay){
    if(choice_IncomePay==0){
      return [Color.fromRGBO(51, 102, 153, 1),Color.fromRGBO(51, 102, 153, 0.5)];
    }
    else{
      return [Color.fromRGBO(153, 51, 51, 1),Color.fromRGBO(153, 51, 51, 0.5)];
    }
  }
}