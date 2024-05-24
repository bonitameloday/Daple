import 'package:google_map/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/fire_model.dart';
import '../data/fire_service.dart';

import 'package:logger/logger.dart';

class EditScreen extends StatelessWidget {
  final FireModel fireModel;

  EditScreen({Key? key, required this.fireModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
    TextEditingController(text: "${fireModel.title}");
    TextEditingController contentController =
    TextEditingController(text: "${fireModel.content}");
    logger.d(fireModel.title);
    logger.d(fireModel.reference);
    logger.d(fireModel.content);

    return Scaffold(
      appBar: AppBar(title: const Text("EDIT")),
      body: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: "Title",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          SizedBox(height: 16), // Adding some space between title and content fields
          Expanded(
            child: TextFormField(
              controller: contentController,
              maxLines: null, // Allow multiple lines for content
              decoration: const InputDecoration(
                hintText: "Content",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // Adding some space between content and send button
          TextButton(
            onPressed: () {
              FireModel updateModel = FireModel(
                title: titleController.text,
                content: contentController.text, // Include content in the update
                date: Timestamp.now(),
              );
              FireService().updateDiary(
                reference: fireModel.reference!,
                json: updateModel.toJson(),
              );
              Navigator.of(context).pop(true);
            },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}