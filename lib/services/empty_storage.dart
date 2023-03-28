import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EmptyStorage {
  final storage = const FlutterSecureStorage();

  Future<void> logout(BuildContext context) async {
    try {
      await storage.deleteAll();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Phoenix.rebirth(context);
    } catch (e) {
      throw Exception('logout failed $e');
    }
  }

  Future<void> removeScale() async {
    try {
      await storage.delete(key: 'scaleId');
      await storage.delete(key: 'scaleName');
    } catch (e) {
      throw Exception('remove scale failed $e');
    }
  }
}
