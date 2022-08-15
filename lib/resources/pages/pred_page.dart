import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../app/controllers/controller.dart';

class PredPage extends NyStatefulWidget {
  final Controller controller = Controller();
  PredPage({Key? key}) : super(key: key);

  @override
  _PredPageState createState() => _PredPageState();
}

class _PredPageState extends NyState<PredPage> {
  @override
  init() async {
    // super.init();
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediksi'),
      ),
      body: WebView(
        initialUrl: 'https://skripsiuy.xyz/c45',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
