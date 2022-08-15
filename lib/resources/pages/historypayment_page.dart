import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/payment_controller.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/controllers/controller.dart';

class HistorypaymentPage extends NyStatefulWidget {
  final PaymentController paymentController = PaymentController();
  HistorypaymentPage({Key? key}) : super(key: key);

  @override
  _HistorypaymentPageState createState() => _HistorypaymentPageState();
}

class _HistorypaymentPageState extends NyState<HistorypaymentPage> {
  List<dynamic> listHistoryPayments = [];
  @override
  init() async {
    super.init();
    var payments = await widget.paymentController.getPaymentsHistory();
    setState(() {
      listHistoryPayments = payments;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Pembayaran'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          child: HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 400,
            isFixedHeader: true,
            headerWidgets: _getTitleWidget(),
            leftSideItemBuilder: _generateFirstColumnRow,
            rightSideItemBuilder: _generateRightHandSideColumnRow,
            itemCount: listHistoryPayments.length,
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
      _getTitleItemWidget('Nama Santri', 100),
      _getTitleItemWidget('Nama Pengurus', 200),
      _getTitleItemWidget('Bulan', 100),
      _getTitleItemWidget('Tahun', 100),
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
      child: Text(listHistoryPayments[index]['has_siswa']['nama']),
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
          child:
              Text(listHistoryPayments[index]['has_petugas']['nama_petugas']),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(listHistoryPayments[index]['bulan_dibayar']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(listHistoryPayments[index]['tahun_dibayar']),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
