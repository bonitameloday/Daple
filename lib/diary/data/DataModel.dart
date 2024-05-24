import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DataModel {
  String title;
  String content;
  String date;

  DataModel({required this.title, required this.content, required this.date});
}
