import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_map/diary/pages/edit.dart';
import 'package:intl/intl.dart';
/// motto : "세계적 클래스의 타이탄들에게는 초능력이 없었다. 대신 그들에게는 뚜렷한 목표(계획)가 있다."
/// date : "2022-03-29 13:02:21"
/// reference : "reference"

class FireModel {
  // 사용되는 자료형

  String? title;
  Timestamp? date;
  String? content;
  DocumentReference? reference;

  //생성자
  FireModel({
    this.title,
    this.date,
    this.content,
    this.reference,
  });

  //json => Object로, firestore에서 불러올때
  FireModel.fromJson(dynamic json, this.reference) {
    title = json['title'];
    date = json['date'];
    content = json['content'];
  }

  // Named Constructor with Initializer
  // fromSnapShot Named Constructor로 snapshot 자료가 들어오면 이걸 다시 Initializer를 통해
  // fromJson Named Constructor를 실행함
  // DocumentSnapshot 자료형을 받아 올때 사용하는 Named Constructor
  // 특정한 자료를 받아 올때 사용한다.
  FireModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  // Named Constructor with Initializer
  // 컬렉션 내에 특정 조건을 만족하는 데이터를 다 가지고 올때 사용한다.
  FireModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  // 파이어 베이스로 저장 할때 쓴다
  //Object => json, firestore에 저장할때
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['date'] = date;
    map['content'] = content;
    return map;
  }
}