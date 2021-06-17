// @dart=2.9
import 'package:flutter/material.dart';
import 'Pages/Home.dart';
import 'Pages/RegisterStudent.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => Home(),
      '/register':(context)=>RegisterStudent()
    },
  ));
}

