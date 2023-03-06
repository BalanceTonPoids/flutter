import 'dart:convert';
import 'dart:io';

import 'package:balancetonpoids/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final http.Client httpClient;
  // final SharedPreferences sharedPreferences;
  final String apiUrl = 'http://localhost:3000/v1';

  ApiClient({required this.httpClient
      // , required this.sharedPreferences
      });

  Future<Map<String, dynamic>> registerUser(
      String email, String password, String confirmPassword) async {
    final alphanumeric = RegExp(r'^[a-zA]');
    final oneNumber = RegExp(r'\d');

    if (email.isEmpty || password.isEmpty) {
      return {'erreur': 'email and password are required'};
    }
    if (!email.contains('@')) {
      return {'erreur': 'email is not valid'};
    }
    if (password != confirmPassword) {
      return {'erreur': 'passwords do not match'};
    }
    if (password.length < 8) {
      return {'erreur': 'password must be at least 8 characters'};
    }
    if (alphanumeric.hasMatch(password) && !oneNumber.hasMatch(password)) {
      return {'erreur': 'password must contain at least one letter'};
    }

    try {
      final response = await httpClient.post(Uri.parse('$apiUrl/auth/register'),
          body: {'email': email, 'password': password});
      switch (response.statusCode) {
        case 200:
          // get token and set it in local storage
          var token = jsonDecode(response.body)['token'];
          await SharedPreferences.getInstance()
              .then((value) => value.setString('token', token));
          // sharedPreferences.setString('token', token);
          return {'success': 'register success'};
        case 400:
          var json = jsonDecode(response.body);
          return json;
        case 500:
          return {'erreur': 'server error'};
        default:
          return {'erreur': 'unknown error'};
      }
    } catch (error) {
      // return {'erreur': 'register failed $error'};
      throw Exception('register failed $error');
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final response = await httpClient.post(Uri.parse('$apiUrl/auth/login'),
          body: {'email': email, 'password': password});
      switch (response.statusCode) {
        case 200:
          // get token and set it in local storage
          var token = jsonDecode(response.body)['token'];
          await SharedPreferences.getInstance()
              .then((value) => value.setString('token', token));
          // sharedPreferences.setString('token', token);
          return true;
        case 400:
          return false;
        case 500:
          return false;
        default:
          return false;
      }
    } catch (e) {
      throw Exception('login failed $e');
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
    final token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token'));
    // final token = sharedPreferences.getString('token');
    if (token != null) {
      return token;
    } else {
      throw Exception('Token not found in local storage');
    }
  }
}
