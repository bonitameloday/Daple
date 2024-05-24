import 'package:google_map/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fire_model.dart';
import 'package:logger/logger.dart';
import 'package:google_map/diary/pages/edit.dart';
import 'package:google_map/diary/pages/diary.dart';


class FireService {
  // 싱글톤 패턴
  static final FireService _fireService = FireService._internal();

  factory FireService() => _fireService;

  FireService._internal();

  //Create
  Future createDiary(Map<String, dynamic> json) async {
    // 초기화
    await FirebaseFirestore.instance.collection("diary").add(json);
  }
  //READ
  Future<List<FireModel>> getFireModel() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection("diary");
    logger.d("getFireModel1");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await collectionReference.orderBy("date").get();
    logger.d("getFireModel2");

    List<FireModel> titles = [];
    for (var doc in querySnapshot.docs) {
      FireModel fireModel = FireModel.fromQuerySnapshot(doc);
      titles.add(fireModel);
    }
    logger.d(titles);
    return titles;
  }

  //UPDATE
  Future updateDiary(
      {required DocumentReference reference, required Map<String, dynamic> json}) async{
    await reference.set(json);
  }

  //DELETE
  Future<void> deleteDiary(DocumentReference reference) async {
    await reference.delete();
  }
}