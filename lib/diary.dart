import 'package:google_map/diary/data/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/home.dart';
import 'package:google_map/diary/pages/diary.dart';
import 'package:google_map/planner/pages/home_page.dart';
import 'package:google_map/study.dart';
import 'package:google_map/diary/pages/edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_map/diary/data/DataModel.dart';
import 'dart:developer';

import 'package:logger/logger.dart';
import 'package:google_map/diary/pages/editscreen.dart';
import 'package:google_map/diary/data/fire_model.dart';
import 'package:google_map/diary/data/fire_service.dart';
import '../../logger.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  State<DiaryPage> createState() => _DiaryPageState();

}

class _DiaryPageState extends State<DiaryPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<List<FireModel>>(
                  future: FireService().getFireModel(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<FireModel> datas = snapshot.data!;
                      return ListView.builder(
                          itemCount: datas.length,
                          itemBuilder: (BuildContext context, int index) {
                            FireModel data = datas[index];
                            return Card(
                                child: ListTile(
                                    title: Text(
                                      "${data.title}", //제목
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data.content}"//내용
                                        ),
                                        Text("${(data.date)!.toDate()}"),//시간
                                      ],
                                    ),
                                    trailing: IconButton(
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
                                                    logger.d(data.reference);
                                                    FireService().deleteDiary(data.reference!);
                                                    setState(() {});
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
                                    onLongPress: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                        return EditScreen(fireModel: data);})).then((value)
                                      {if(value){setState(() {});
                                      }
                                      }
                                      );
                                    }));
                          });
                    } else {
                      logger.d("CircularProgressIndicator");
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}