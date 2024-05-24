import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("로그아웃"),),
      body: Center(
        child: Text("로그아웃"),
      ),
    );
  }
}