import 'dart:math';

import 'package:google_map/diary/data/fire_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_map/home.dart';
import 'package:google_map/diary/data/fire_model.dart';
import 'diary.dart';
import '../data/firebase_options.dart';
import 'package:intl/intl.dart';

import '../../logger.dart';


class EditPage extends StatefulWidget {
  final DateTime selectedDate;

  const EditPage({required this.selectedDate, super.key});

  @override
  EditPageState createState() => EditPageState();

}

  class EditPageState extends State<EditPage> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  TextEditingController _inputController = TextEditingController();
  Future<List<FireModel>>? _future;

  @override
  void dispose() {
  _inputController.dispose();
  super.dispose();
  }

  @override
  void initState() {
  logger.d("initState");
  _future = FireService().getFireModel();
  super.initState();
  }

  String title="";
  String content="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("삭제할까요?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text("삭제"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        child: Text("취소"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      bottomSheet: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("저장할까요?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context, rootNavigator: true).pop();
                              FireModel _fireModel = FireModel(

                                  title: titleController.text,
                                  content: contentController.text,
                                  date: Timestamp.now());

                              await FireService().createDiary(_fireModel.toJson());

                            },
                            child: Text("저장"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            child: Text("취소"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

            )
        ),

      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ),
            TextField(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목을 적어주세요.',
              ),
              onChanged: (value){
                setState(() {
                  title=value;
                });
              },
            ),
            Padding(
                padding: EdgeInsets.all(5)),
            TextField( style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              keyboardType: TextInputType.multiline,
              maxLines: 18,
              controller: contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '오늘 하루를 적어주세요.',
              ),
            ),

          ],
        ),
      ),

    );

  }
}