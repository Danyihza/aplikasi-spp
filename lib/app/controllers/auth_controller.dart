import 'dart:convert';

import 'package:nylo_framework/nylo_framework.dart';

import 'controller.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AuthController extends Controller {
  construct(BuildContext context) {
    super.construct(context);
  }

  dynamic signin({required String username, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var url = Uri.parse(getEnv('API_BASE_URL') + '/signin');
    var response = await http.post(url, body: {
      "username": username,
      "password": password,
    });
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}
