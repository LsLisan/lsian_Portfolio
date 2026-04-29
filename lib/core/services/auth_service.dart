
import 'dart:core';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  /// constant for shared preference keys
  static const String _tokenKey = 'token';
  static const String _userRoleKey = 'userRole';
  static const String _isSetUpKey = 'isSetUp';
  static const String _userIdKey = 'userId';
  static const String _isProfileSetupKey = 'isProfileSetup';

  /// Singletone instance
  static late SharedPreferences _preferences;

  /// private variables to hold value in memory
  static String? _token;
  static String? _userRole;
  static bool? _userSetUp;
  static bool? _isSetup;
  static String? _id;
  static bool? _isProfileSetUp;

  /// Initialize SharedPreferences (need to call this in main.dart) 
  static Future<void> init() async{
    _preferences = await SharedPreferences.getInstance();
    
    /// load data from Shared preference into private variables using the keys
    _token = _preferences.getString(_tokenKey);
    _userRole = _preferences.getString(_userRoleKey);
    _userSetUp = _preferences.getBool(_userRoleKey);
    _id = _preferences.getString(_userIdKey);
    _isProfileSetUp = _preferences.getBool(_isProfileSetupKey);
    _isSetup = _preferences.getBool(_isSetUpKey);
    
  }

  /// Save Methods
  static Future<void> saveToken(String token)async{
    try{
      await _preferences.setString(_tokenKey, token);
    }catch(e){
      log('Auth Service Token Saving Error: $e');
    }
  }

  static Future<void> saveId(String id)async{
    try{
      await _preferences.setString(_userIdKey, id);
    }catch(e){
      log('Auth Service Token Saving Error: $e');
    }
  }

  static Future<void> saveRole(String role)async{
    try{
      await _preferences.setString(_userRoleKey, role);
    }catch(e){
      log('Auth Service Token Saving Error: $e');
    }
  }

  static Future<void> saveSetUpStatus(bool setUp)async{
    try{
      await _preferences.setBool(_isSetUpKey, setUp);
    }catch(e){
      log('Auth Service Token Saving Error: $e');
    }
  }

  static Future<void> saveProfileSetUp(bool profileSetUp)async{
    try{
      await _preferences.setBool(_isProfileSetupKey, profileSetUp);
    }catch(e){
      log('Auth Service Token Saving Error: $e');
    }
  }

  static bool hasToken(){
    return _preferences.containsKey(_tokenKey);
  }

  /// Gatters
  static String? get token => _token;
  static String? get userRole => _userRole;
  static bool? get userSetUp => _userSetUp;
  static String? get id => _id;
  static bool? get isProfileSetUp => _isProfileSetUp;

}