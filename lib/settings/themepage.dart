import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  String title = '테마 선택';

  Color pickerColor= const Color(0xff2196f3);
  Color currentColor= const Color(0xff2196f3);
  void changeColor(Color color){
    setState(() {
      pickerColor=color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: pickerColor,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('테마 색상 선택', style: TextStyle(fontSize: 18.0),),
              Divider(),
              Text('선택 색상', style: TextStyle(fontSize: 30.0),),
              Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: pickerColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                      padding: EdgeInsets.only(
                          left: 30.0, top:0.0, right: 30.0, bottom: 0.0)),
                  onPressed: () {
                    colorPickerDialog();
                  },
                  child: Text('색상 선택'))
            ],
          )),
    );
  }
  Future colorPickerDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        content: SingleChildScrollView(child: BlockPicker(pickerColor: pickerColor, onColorChanged: changeColor,)),

        actions: <Widget>[
          TextButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                padding: const EdgeInsets.only(
                    left: 30.0, top: 0.0, right: 30.0, bottom: 0.0)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
                'CLOSE', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}