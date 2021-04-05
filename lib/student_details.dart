import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_details/student_info_model.dart';
import 'IOnDetailsClick.dart';

class StudentDetails extends StatefulWidget {
  final IOnDetailsClick onDetailsClick;
  final InfoStudentModel model;
  StudentDetails(this.onDetailsClick, this.model,{Key key,}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  var _controllerNameTF = TextEditingController();
  var _controllerAgeTF = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: TextField(
              controller: _controllerNameTF..text
              = widget.model.name
            ),
            height: 40,
          ),
          Container(
              margin: EdgeInsets.all(8),
              child: TextField(
                controller: _controllerAgeTF..text
                = widget.model.age.toString(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              height: 40),
          FlatButton(
              color: Colors.blue,
              onPressed: () {
                if (_controllerNameTF.text.isEmpty ||
                    _controllerAgeTF.text.isEmpty) {
                  return;
                }
                widget.onDetailsClick.updateDataInfoStudent(
                    InfoStudentModel(widget.model.index,
                        _controllerNameTF.text, int.parse(_controllerAgeTF
                            .text), widget.model.className));
                Navigator.pop(context);
              },
              child: Text('Save Student'))
        ],
      ),
    );
  }
}