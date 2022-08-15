import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/dashboard_page.dart';
import 'package:flutter_app/resources/pages/history_by_id_page.dart';
import 'package:flutter_app/resources/pages/historypayment_page.dart';
import 'package:flutter_app/resources/pages/pred_page.dart';
import 'package:flutter_app/resources/pages/student_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../app/controllers/controller.dart';

class HomePage extends NyStatefulWidget {
  final Controller controller = Controller();
  final int idx;
  HomePage({Key? key, this.idx = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  int _selectedIndex = 0;
  dynamic _widgetOptions = [
    DashboardPage(),
    StudentPage(),
    HistorypaymentPage(),
    PredPage(),
  ];

  @override
  init() async {
    super.init();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    setState(() {
      _selectedIndex = widget.idx;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Santri',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'H. Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Prediksi',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
