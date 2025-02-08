import 'dart:async';
import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

class SeassionManager {
  static final SeassionManager _instance = SeassionManager._internal();

  final _tokenController = StreamController<bool>.broadcast();
  Stream<bool> get tokenStatusStream => _tokenController.stream;

  factory SeassionManager() {
    return _instance;
  }

  SeassionManager._internal();

  Future<bool> setAccessToken(String key, String object) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool result = await prefs.setString(key, object);
      _tokenController.add(result);
      return result;
    } catch (e) {
      _tokenController.add(false);
      return false;
    }
  }

  Future<String?> getAccessToken(String key) async {
    print('function running again ');
    final prefs = await SharedPreferences.getInstance();
    final token =  prefs.getString(key);
    print('Xauth token ============+>$token');
    if(token != null){
      _tokenController.add(true);
    }else{
      _tokenController.add(false);
    }
    return token ;
  }

  Future<bool> removeAccessToken(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool result = await prefs.remove(key);

      _tokenController.add(false);
      return result;
    } catch (e) {
      _tokenController.add(false);
      return false;
    }
  }

  Future<bool> saveObjectToSharedPreferences(
      String key, Map<String, dynamic> object) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStringData = jsonEncode(object);
      return await prefs.setString(key, jsonStringData);
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getObjectFromSharedPreferences(
      String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);
      if (jsonString != null) {
        return jsonDecode(jsonString);
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  removeObjectFromSharedPreferences(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key);
    } catch (error) {
      rethrow;
    }
  }
}
