import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/*
控制TextField_decoration樣式
 */

class TextFieldDecoration{
  InputDecoration textInputDecoration([String labelText='' , String hintText='']){
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      //點選輸入時顏色變換
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0),borderSide: BorderSide(color: Colors.pink.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0),borderSide: const BorderSide(color: Colors.pink)),
    );
  }
}