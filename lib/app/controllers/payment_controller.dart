import 'dart:convert';

import 'package:nylo_framework/nylo_framework.dart';

import 'controller.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class PaymentController extends Controller {
  
  construct(BuildContext context) {
    super.construct(context);

  }

  dynamic getPaymentsHistory() async{
    var url = Uri.parse(getEnv('API_BASE_URL') + '/payment-history');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["data"];
  }

  dynamic getPaymentsHistoryById({nisn}) async {
    var url = Uri.parse(getEnv('API_BASE_URL') + '/payment-history/$nisn');
    var response = await http.get(url);
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["data"];
  }

} 
