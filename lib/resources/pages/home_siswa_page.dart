import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/dashboard_page.dart';
import 'package:flutter_app/resources/pages/history_by_id_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';

class HomeSiswaPage extends NyStatefulWidget {
  final Controller controller = Controller();
  HomeSiswaPage({Key? key}) : super(key: key);
  
  @override
  _HomeSiswaPageState createState() => _HomeSiswaPageState();
}

class _HomeSiswaPageState extends NyState<HomeSiswaPage> {
  int _selectedIndex = 0;
  dynamic _widgetOptions = [
    DashboardPage(),
    HistoryByIdPage(),
  ];

  @override
  init() async {
    
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
            icon: Icon(Icons.payment),
            label: 'History Pembayaran',
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
