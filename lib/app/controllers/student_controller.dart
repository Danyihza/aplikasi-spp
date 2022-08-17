import 'dart:convert';

import 'package:nylo_framework/nylo_framework.dart';

import 'controller.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class StudentController extends Controller {
  construct(BuildContext context) {
    super.construct(context);
  }

  dynamic getStudents() async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/students');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["data"];
  }

  dynamic getStudent({nisn}) async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/student/$nisn');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["data"];
  }

  dynamic getClasses() async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/classes');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse["data"];
  }

  dynamic getSPP() async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/spp');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse["data"];
  }

  dynamic storeStudent(
      {nisn,
      nis,
      nama,
      username,
      password,
      id_kelas,
      alamat,
      tempat,
      tanggal,
      no_telp,
      id_spp}) async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/student/add');
    var response = await http.post(url, body: {
      "nisn": nisn,
      "nis": nis,
      "nama": nama,
      "username": username,
      "password": password,
      "id_kelas": id_kelas.toString(),
      "alamat": alamat,
      "tempat": tempat,
      "tanggal": tanggal,
      "no_telp": no_telp,
      "id_spp": id_spp.toString()
    });
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse;
  }

  dynamic updateStudent(
      {nisn,
      nis,
      nama,
      username,
      password,
      id_kelas,
      alamat,
      tempat,
      tanggal,
      no_telp,
      id_spp}) async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/student/update');
    var response = await http.post(url, body: {
      "nisn": nisn,
      "nis": nis,
      "nama": nama,
      "username": username,
      "password": password ?? '',
      "id_kelas": id_kelas.toString(),
      "alamat": alamat,
      "tempat": tempat,
      "tanggal": tanggal,
      "no_telp": no_telp,
      "id_spp": id_spp.toString()
    });
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse;
  }

  dynamic deleteStudent({nisn}) async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/student/delete/$nisn');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return true;
  }
}
