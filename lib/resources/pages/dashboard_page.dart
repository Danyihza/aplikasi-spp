import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends NyStatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends NyState<DashboardPage> {
  String? _nama = '';
  String? _role = '';

  @override
  init() {
    super.init();
    _getLoginData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getLoginData() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _nama = prefs.getString('name');
        _role = prefs.getString('role') == 'siswa' ? 'santri' : 'admin';
      });
    });
  }

  void _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('role');
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text('Home'),
      // ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Aplikasi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      'Pembayaran',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70),
                Image.asset(
                  getImageAsset("illustration-home.png"),
                  height: 250,
                  width: 250,
                ),
                SizedBox(height: 20),
                Text(
                  'Halo $_nama, Kamu masuk sebagai $_role',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _signOut();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    child: Text(
                      'Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
