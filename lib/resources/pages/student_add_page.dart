import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/student_controller.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';

class StudentAddPage extends NyStatefulWidget {
  final StudentController studentController = StudentController();
  StudentAddPage({Key? key}) : super(key: key);

  @override
  _StudentAddPageState createState() => _StudentAddPageState();
}

class _StudentAddPageState extends NyState<StudentAddPage> {
  dynamic _kelas = 0;
  dynamic _spp = 0;
  List kelasList = [];
  List sppList = [];

  TextEditingController _nisnController = TextEditingController();
  TextEditingController _nisController = TextEditingController();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _notelpController = TextEditingController();

  @override
  init() async {
    super.init();
    _setKelas();
    _setSpp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setKelas() async {
    var kelas = await widget.studentController.getClasses();
    setState(() {
      _kelas = kelas[0]['id'];
      kelasList = kelas;
    });
  }

  void _setSpp() async {
    var spp = await widget.studentController.getSPP();
    setState(() {
      _spp = spp[0]['id'];
      sppList = spp;
    });
  }

  void _storeData() async {
    var response = await widget.studentController.storeStudent(
        nisn: _nisnController.text,
        nis: _nisController.text,
        nama: _namaController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        id_kelas: _kelas,
        alamat: _alamatController.text,
        no_telp: _notelpController.text,
        id_spp: _spp);
    if (response['success'] == true) {
      _nisnController.clear();
      _nisController.clear();
      _namaController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _alamatController.clear();
      _notelpController.clear();
      showToast(title: 'Success', description: "Data berhasil ditambahkan");
      
    } else {
      print(response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Santri'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
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
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  _storeData();
                },
                child: Text(
                  'Tambah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
