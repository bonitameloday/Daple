import 'package:google_map/diary/data/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map/home.dart';
import 'package:google_map/diary/pages/diary.dart';
import 'package:google_map/planner/pages/home_page.dart';
import 'edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/DataModel.dart';
import 'dart:developer';

import 'package:logger/logger.dart';
import 'editscreen.dart';
import '../data/fire_model.dart';
import '../data/fire_service.dart';
import '../../logger.dart';

import 'package:flutter/material.dart';

class DiaryNote extends StatelessWidget {
  const DiaryNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightGreen,
                boxShadow:[
                BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5
    ) //날짜박스 그림자
    ]
    ),
            child: Column(
              children: [
                Text(
                  'DEC',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 3),
                Text(
                  '03',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '2024',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '제목',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '12:30 PM',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Text(
                  'Here is the dexcription of this note.Here is the dexcription of this note.Here is the dexcription of this note.Here is the dexcription of this note.',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      height: 1.5
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}