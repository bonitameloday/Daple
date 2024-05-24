import 'package:flutter/material.dart';

class DeletePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("회원탈퇴"),),
      body: Center(
        child: Text("회원탈퇴"),
      ),
    );
  }
}