import 'package:flutter/material.dart';
import 'package:flutter_list_details/project_constants.dart';
import 'package:flutter_list_details/student_details.dart';
import 'package:flutter_list_details/student_info_model.dart';
import 'IOnDetailsClick.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List - Details',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
          child: MyHomePage(
            title: 'Student Information List',
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements IOnDetailsClick {
  var dataInfo = <InfoStudentModel>[];

  void initState() {
    super.initState();
    dataInfo.add(InfoStudentModel(0, "Huy", 20, ProjectConstants.classNameDefault));
    dataInfo.add(InfoStudentModel(1, "Quang", 21, ProjectConstants.classNameDefault));
    dataInfo.add(InfoStudentModel(2, "Minh", 22, ProjectConstants.classNameDefault));
    dataInfo.add(InfoStudentModel(3, "Duy", 23, ProjectConstants.classNameDefault));
    dataInfo.add(InfoStudentModel(4, "Tung", 24, ProjectConstants.classNameDefault));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: dataInfo.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Name : ' +
                  dataInfo[index].name +
                  '\nAge : ' +
                  dataInfo[index].age.toString()),
              trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.edit)
                        , onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(builder: (context) {
                            return StudentDetails(this, dataInfo[index]);
                          }));
                        }
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          dataInfo.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete),
                    )
                  ]
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) {
            return StudentDetails(this, new InfoStudentModel(ProjectConstants
                    .newIndex, ProjectConstants.stringEmpty, ProjectConstants
                    .ageDefault, ProjectConstants.classNameDefault));
          }));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
    );
  }

  @override
  void updateDataInfoStudent(InfoStudentModel studentModel) {
    setState(() {
      if (studentModel.index == ProjectConstants.newIndex) {
        studentModel.index = dataInfo.length;
        dataInfo.add(studentModel);
      }
      else{
        for (int i=0; i < dataInfo.length; i++){
          if (dataInfo[i].index == studentModel.index){
            dataInfo[i].name = studentModel.name;
            dataInfo[i].age = studentModel.age;
            break;
          }
        }
      }
    });
  }
}
