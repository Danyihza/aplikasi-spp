import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/student_controller.dart';
import 'package:flutter_app/resources/pages/student_edit_page.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';

class StudentPage extends NyStatefulWidget {
  final StudentController studentController = StudentController();
  StudentPage({Key? key}) : super(key: key);

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends NyState<StudentPage> {
  List<dynamic> listStudents = [];

  @override
  init() async {
    super.init();
    var students = await widget.studentController.getStudents();
    setState(() {
      listStudents = students;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _deleteData(nisn) async {
    var response = await widget.studentController.deleteStudent(nisn: nisn);
    if (response == true) _getStudentData();
  }

  void _getStudentData() async {
    var students = await widget.studentController.getStudents();
    setState(() {
      listStudents = students;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Santri'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          routeTo('/student/add');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 750,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: listStudents.length,
            rowSeparatorWidget: const Divider(
              color: Colors.black54,
              height: 1.0,
              thickness: 0.0,
            ),
            leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
            rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('NISN', 100),
      _getTitleItemWidget('NIS', 100),
      _getTitleItemWidget('Nama', 100),
      _getTitleItemWidget('Kelas', 100),
      _getTitleItemWidget('No Telepon', 200),
      _getTitleItemWidget('Aksi', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(listStudents[index]['nisn'].toString()),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(listStudents[index]['nis'].toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(listStudents[index]['nama'].toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child:
              Text(listStudents[index]['has_kelas']['nama_kelas'].toString()),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(listStudents[index]['no_telp'].toString()),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  _deleteData(listStudents[index]['nisn']);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    Text(
                      'Hapus',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StudentEditPage(
                            nisn: listStudents[index]['nisn']);
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ),
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
