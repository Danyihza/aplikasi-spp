import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';

class HistorypaymentsByIdPage extends NyStatefulWidget {
  final Controller controller = Controller();
  HistorypaymentsByIdPage({Key? key, dynamic args}) : super(key: key);

  dynamic args;

  @override
  _HistorypaymentsByIdPageState createState() =>
      _HistorypaymentsByIdPageState();
}

class _HistorypaymentsByIdPageState extends NyState<HistorypaymentsByIdPage> {
  @override
  init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('Nama Santri : '),
              Text('Nama Petugas : '),
              Text('Bulan : '),
              Text('Tahun : '),
            ],
          ),
        ),
      ),
    );
  }
}
