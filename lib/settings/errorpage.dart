import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("버그/오류 제보"),),
      body: Center(
        child: Text("버그/오류 제보"),
      ),
    );
  }
}