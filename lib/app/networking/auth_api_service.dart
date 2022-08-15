import 'package:flutter/material.dart';
import '../../app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

class AuthApiService extends BaseApiService {
  AuthApiService({BuildContext? buildContext}) : super(buildContext);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  /// Example API Request
  Future<dynamic> signinUser(
      {required String username, required String password}) async {
    return await network<dynamic>(
      request: (request) => request.post("/signin", data: {
        "username": username,
        "password": password,
      }),
    );
  }
}
