import '/tools/string.dart';
import 'package:flutter/material.dart';

inputvalidator(String val , int max , int min ) {
  if (val.length > max) {
    return "$maxmessage";
  }
  if (val.isEmpty) {
    return "$emptymessage";
  }
  if (val.length < min) {
    return "$minmessage";
  }
}

 validateEmail(String? value) {
  if (value != null) {
    if (value.length > 5 && value.contains('@') && value.endsWith('.com')) {
      return null;
    }
    return 'Enter a Valid Email Address';
  }
}
inputtitle(String val){
  if (val.isEmpty){
    return "$emptymessage";
  }
}