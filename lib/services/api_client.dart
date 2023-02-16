import 'dart:convert';
import 'dart:io';

import 'package:balancetonpoids/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final http.Client httpClient;
  final SharedPreferences sharedPreferences;
  final String apiUrl = 'https://http://localhost:3000/v1';

  ApiClient({required this.httpClient, required this.sharedPreferences});

  void registerUser(String email, String password) async {
    final response = await httpClient.post(Uri.parse('$apiUrl/auth/register'),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      // get token and set it in local storage
      var token = jsonDecode(response.body)['token'];
      sharedPreferences.setString('token', token);
    } else {
      throw Exception('register failed');
    }
  }

  void loginUser(String email, String password) async {
    final response = await httpClient.post(Uri.parse('$apiUrl/auth/login'),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      // get token and set it in local storage
      var token = jsonDecode(response.body)['token'];
      sharedPreferences.setString('token', token);
    } else {
      throw Exception('login failed');
    }
  }

  Future<User> getUserInfo() async {
    final token = await getHeaderToken();
    final response = await httpClient.get(
      Uri.parse('$apiUrl/users'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      // parse the user info from the response body and return it
      return User.fromJson(response.body as Map<String, dynamic>);
    } else {
      throw Exception('Failed to get user info');
    }
  }

  Future<String> getHeaderToken() async {
    // Retrieve the token from local storage
    final token = sharedPreferences.getString('token');
    if (token != null) {
      return token;
    } else {
      throw Exception('Token not found in local storage');
    }
  }
}
