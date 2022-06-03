import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelbuddies_mobile/config.dart';
import 'package:travelbuddies_mobile/models/login_request_model.dart';
import 'package:travelbuddies_mobile/models/login_response_model.dart';
import 'package:travelbuddies_mobile/models/register_request_model.dart';
import 'package:travelbuddies_mobile/models/register_response_model.dart';
import 'package:travelbuddies_mobile/services/shared_services.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //Shared Services
      await SharedServices.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }
}
