import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/student_controller.dart';
import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/controllers/controller.dart';
import 'package:intl/intl.dart';

class StudentEditPage extends NyStatefulWidget {
  final int nisn;
  final StudentController studentController = StudentController();
  StudentEditPage({Key? key, required this.nisn}) : super(key: key);

  @override
  _StudentEditPageState createState() => _StudentEditPageState();
}

class _StudentEditPageState extends NyState<StudentEditPage> {
  dynamic _kelas = 0;
  dynamic _spp = 0;
  List kelasList = [];
  List sppList = [];
  dynamic studentData = {};

  TextEditingController _nisnController = TextEditingController();
  TextEditingController _nisController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _notelpController = TextEditingController();
  TextEditingController _tempatController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();

  @override
  init() async {
    super.init();
    _setKelas();
    _setSpp();
    _setStudentData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setStudentData() {
    var response = widget.studentController.getStudent(nisn: widget.nisn);
    setState(() {
      studentData = response;
    });
  }

  void _setKelas() async {
    var kelas = await widget.studentController.getClasses();
    var kelasId = await widget.studentController.getStudent(nisn: widget.nisn);
    setState(() {
      kelasList = kelas;
      print(kelasId['id_kelas'].runtimeType);
      _kelas = kelasId['id_kelas'].runtimeType == int
          ? kelasId['id_kelas']
          : int.parse(kelasId['id_kelas']);
    });
  }

  void _setSpp() async {
    var spp = await widget.studentController.getSPP();
    var sppId = await widget.studentController.getStudent(nisn: widget.nisn);
    setState(() {
      sppList = spp;
      _spp = sppId['id_spp'].runtimeType == int
          ? sppId['id_spp']
          : int.parse(sppId['id_spp']);
    });
  }

  void _saveData() async {
    var response = await widget.studentController.updateStudent(
        nisn: _nisnController.text,
        nis: _nisController.text,
        nama: _namaController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        id_kelas: _kelas,
        alamat: _alamatController.text,
        tempat: _tempatController.text,
        tanggal: _tanggalController.text,
        no_telp: _notelpController.text,
        id_spp: _spp);
    if (response['success'] == true) {
      _nisnController.clear();
      _nisController.clear();
      _namaController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _alamatController.clear();
      _tempatController.clear();
      _tanggalController.clear();
      _notelpController.clear();
      showToast(title: 'Success', description: "Data berhasil diupdate");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return HomePage(
          idx: 1,
        );
      }));
    } else {
      showToast(
        title: 'Error',
        description: "Data gagal diupdate",
        style: ToastNotificationStyleType.DANGER,
      );
      print(response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Santri'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: studentData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data! as Map<dynamic, dynamic>;
                _nisnController.text = data['nisn'].toString();
                _nisController.text = data['nis'].toString();
                _namaController.text = data['nama'].toString();
                _usernameController.text = data['username'].toString();
                _alamatController.text = data['alamat'].toString();
                _notelpController.text = data['no_telp'].toString();
                _tempatController.text = data['tempat'].toString();
                _tanggalController.text = data['tanggal'].toString();
                return Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: _nisnController,
                      decoration: InputDecoration(
                        labelText: 'NISN',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _nisController,
                      decoration: InputDecoration(
                        labelText: 'NIS',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama Santri',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _tempatController,
                      decoration: InputDecoration(
                        labelText: 'Tempat lahir',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller:
                          _tanggalController, //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: 'Tanggal Lahir', //label text of field
                        border: OutlineInputBorder(),
                      ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            _tanggalController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: _kelas,
                        items: kelasList.map((value) {
                          return DropdownMenuItem(
                            value: value['id'],
                            child: Text(value['text']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _kelas = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _alamatController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Alamat',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _notelpController,
                      decoration: InputDecoration(
                        labelText: 'No Telepon',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField(
                        hint: Text('Tahun Masuk'),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: _spp,
                        items: sppList.map((value) {
                          return DropdownMenuItem(
                            value: value['id'],
                            child: Text(value['text']),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _spp = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        _saveData();
                      },
                      child: Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
