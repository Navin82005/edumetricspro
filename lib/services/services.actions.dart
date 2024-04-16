import 'package:edumetricspro/themes/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  final String apiUrl;

  AuthService(this.apiUrl);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final String url = '$apiUrl/auth/jwt/create/';
    final response = await http.post(Uri.parse(url), body: {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String accessToken = responseData['access'];
      final String refreshToken = responseData['refresh'];
      await _storeTokens(accessToken, refreshToken);
      return {'success': true};
    } else {
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> loadUser() async {
    final String? accessToken = await _getAccessToken();
    if (accessToken != null) {
      final String url = '$apiUrl/auth/users/me/';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return {'success': true, 'data': responseData};
      }
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>> getUserData() async {
    final String? accessToken = await _getAccessToken();
    if (accessToken != null) {
      final String url = '$apiUrl/auth/data/me/';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $accessToken',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _storeUserData(responseData);
        return {'success': true, 'data': responseData};
      }
    }
    return {'success': false};
  }

  Future<void> _storeUserData(Map<String, dynamic> responseData) async {
    final prefs = await SharedPreferences.getInstance();
    if (responseData["type"] == "student") {
      await prefs.setString('userType', "student");
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('name', responseData["name"]);
      await prefs.setString('sem', responseData["sem"]);
      await prefs.setString('rollNumber', responseData["rollNumber"]);
      await prefs.setString('registerNumber', responseData["registerNumber"]);
      await prefs.setString('lectureHall', responseData["lectureHall"]);
      await prefs.setString('inClass', responseData["inClass"]);
      await prefs.setString('userMobile', responseData["userMobile"]);
      await prefs.setString('userDob', responseData["userDob"]);
      await prefs.setString('department', responseData["department"]);
    }
  }

  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', accessToken);
    await prefs.setString('refresh', refreshToken);
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access');
  }

  Future<String?> getAccessToken() async {
    return await _getAccessToken();
  }

  Future<Map<String, dynamic>> googleAuthenticate(
      String state, String code) async {
    if (state.isNotEmpty && code.isNotEmpty) {
      final String url = '$apiUrl/auth/o/google-oauth2/';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'state': state,
          'code': code,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['access'];
        final String refreshToken = responseData['refresh'];
        await _storeTokens(accessToken, refreshToken);
        return {'success': true};
      } else {
        return {'success': false};
      }
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>> facebookAuthenticate(
      String state, String code) async {
    if (state.isNotEmpty && code.isNotEmpty) {
      final String url = '$apiUrl/auth/o/facebook/';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'state': state,
          'code': code,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['access'];
        final String refreshToken = responseData['refresh'];
        await _storeTokens(accessToken, refreshToken);
        return {'success': true};
      } else {
        return {'success': false};
      }
    }
    return {'success': false};
  }

  Future<Map<String, dynamic>> checkAuthenticated() async {
    final String? accessToken = await _getAccessToken();
    if (accessToken != null) {
      final String url = '$apiUrl/auth/jwt/verify/';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({'token': accessToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['code'] != 'token_not_valid') {
          return {'success': true};
        }
      }
    }
    return {'success': false};
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('access');
    await prefs.remove('refresh');
  }
}

final service = AuthService(AppConfig.backendUrl);
