import 'dart:convert';
import 'dart:io';

import 'package:balancetonpoids/models/scale_data.dart';
import 'package:balancetonpoids/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final http.Client httpClient;
  final String apiUrl = 'http://balancetonpoids.alexisbriet.fr/v1';
  final storage = const FlutterSecureStorage();

  ApiClient({required this.httpClient});

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
          await storage.write(key: 'token', value: token);
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
          await storage.write(key: 'token', value: token);
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

  Future<bool> getUserInfo() async {
    try {
      final token = await getHeaderToken();
      final response = await httpClient.get(
        Uri.parse('$apiUrl/users'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      switch (response.statusCode) {
        case 200:
          // parse the user info from the response body and return it
          final user =
              User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
          // set the user in local storage
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', user.name);
          await prefs.setString('email', user.email);
          await prefs.setString('phone', user.phone);
          await prefs.setString('gender', user.gender);
          await prefs.setString('metric', user.metric);
          await prefs.setInt('age', user.age);
          await prefs.setInt('height', user.height);
          final lastScale = user.getLastScale();
          if (lastScale != null) {
            await prefs.setDouble('weight', lastScale.weight);
            await prefs.setString('date', lastScale.date);
          } else {
            await prefs.setDouble('weight', 0.0);
            await prefs.setString('date', '');
          }
          final scaleDataList = user.scaleData;
          if (scaleDataList.isNotEmpty) {
            final List<String> encodedScaleDataList =
                ScaleData.encode(scaleDataList);
            await prefs.setStringList('scale', encodedScaleDataList);
          } else {
            await prefs.setStringList('scale', []);
          }
          return true;
        case 401:
        case 403:
        case 404:
        case 500:
        default:
          return false;
      }
    } catch (e) {
      throw Exception('Failed to get user info $e');
    }
  }

  Future<bool> updateUser(String name, String phone, String gender,
      String metric, int age, int height) async {
    var body = {};
    if (name.isNotEmpty) {
      body['name'] = name;
    }
    if (phone.isNotEmpty) {
      body['phone'] = phone;
    }
    if (gender.isNotEmpty) {
      body['gender'] = gender;
    }
    if (metric.isNotEmpty) {
      body['metric'] = metric;
    }
    if (age != 0) {
      body['age'] = age;
    }
    if (height != 0) {
      body['height'] = height;
    }
    try {
      final token = await getHeaderToken();
      final response = await httpClient.put(
        Uri.parse('$apiUrl/users'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      switch (response.statusCode) {
        case 200:
        case 201:
          // parse the user info from the response body and return it
          final user = jsonDecode(response.body);
          // set the user in local storage
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', user['name'] ?? '');
          await prefs.setString('email', user['email'] ?? '');
          await prefs.setString('phone', user['phone'] ?? '');
          await prefs.setString('gender', user['gender'] ?? '');
          await prefs.setString('metric', user['metric'] ?? '');
          await prefs.setInt('age', user['age'] ?? 0);
          await prefs.setInt('height', user['height'] ?? 0);
          return true;
        case 401:
        case 403:
        case 404:
        case 500:
        default:
          return false;
      }
    } catch (e) {
      throw Exception('Failed to get user info $e');
    }
  }

  Future<Map<String, dynamic>> updateSecurityUser(
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
      final token = await getHeaderToken();
      final response = await httpClient.put(
        Uri.parse('$apiUrl/users'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: {'email': email, 'password': password},
      );
      switch (response.statusCode) {
        case 200:
        case 201:
          final user = jsonDecode(response.body);
          // set the user in local storage
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', user['email']);
          return {'success': 'user updated'};
        case 400:
          var json = jsonDecode(response.body);
          return json;
        case 500:
          return {'erreur': 'server error'};
        default:
          return {'erreur': 'unknown error'};
      }
    } catch (error) {
      return {'erreur': 'update security failed $error'};
      // throw Exception('update security failed $error');
    }
  }

  Future<Map<String, dynamic>> sendScaleData(ScaleData data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', data.weight);
    await prefs.setString('date', data.date);

    final rawScaleDataList = prefs.getStringList('scale') ?? [];
    final List<ScaleData> scaleDataList = ScaleData.decode(rawScaleDataList);
    scaleDataList.add(data);

    if (scaleDataList.isNotEmpty) {
      final List<String> encodedScaleDataList = ScaleData.encode(scaleDataList);
      await prefs.setStringList('scale', encodedScaleDataList);
    } else {
      await prefs.setStringList('scale', []);
    }
    try {
      final token = await getHeaderToken();
      final response = await httpClient.post(
        Uri.parse('$apiUrl/data_scale'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'weight': data.weight,
          'date': data.date,
          'water': data.water,
          'muscle': data.muscle,
          'fat': data.fat,
          'IMC': data.imc,
        }),
      );
      switch (response.statusCode) {
        case 200:
          return {'success': 'scale data sent'};
        case 201:
          return {'success': 'scale data added'};
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
      throw Exception('send scale data fail $error');
    }
  }

  Future<Map<String, dynamic>> resetPwd(String email) async {
    try {
      final response = await httpClient.post(
          Uri.parse('$apiUrl/auth/forgotPassword'),
          body: {'email': email});
      switch (response.statusCode) {
        case 200:
          final res = jsonDecode(response.body);
          return res;
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

  Future<String> getHeaderToken() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      return token;
    } else {
      return '';
    }
  }
}
