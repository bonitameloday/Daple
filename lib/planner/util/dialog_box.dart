import 'package:flutter/material.dart';
import 'my_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  int _selectedColor=0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[50],
      content: StatefulBuilder(
        builder:(BuildContext context, StateSetter setState){
          return Container(
            height: 140,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // get user input
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "오늘 할 일을 추가해요",
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // save button
                      MyButton(text: "추가", onPressed: onSave),

                      const SizedBox(width: 8),

                      // cancel button
                      MyButton(text: "취소", onPressed: onCancel),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



