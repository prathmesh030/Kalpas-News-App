import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthAPI with ChangeNotifier {
  UserModel? _authUser;

  // auth fun
  Future _authenticate(String email, String password, String urlSegment) async {
    final url = Uri.parse("https://kalpasauthapi.herokuapp.com/${urlSegment}");
    print(url);

    try {
      final res = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      print(res.body);

      final resData = json.decode(res.body);
      print(resData['status']);
      if (resData['status'] != "success") {
        // print(resData['message']);
        return resData['message'];
      }

      // print(resData['userData']['email']);
      String userEmail = resData['userData']['email'];
      DateTime expireDate = DateTime.now().add(Duration(seconds: 200));
      // autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
          {"userEmail": userEmail, "expiryDate": expireDate.toIso8601String()});

      prefs.setString("userData", userData);

      return null;

      // prefs.setString("userData", userData);
    } catch (err) {
      // print(err);
      throw err;
    }
  }

// register
  Future signUp(String email, String password) async {
    return _authenticate(email, password, 'register');
  }

// login
  Future login(String email, String password) async {
    return _authenticate(email, password, 'login');
  }

// auto login
  Future tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }

    final extractedUserData = json
        .decode(prefs.getString("userData").toString()) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    // print(extractedUserData);
    if (expiryDate.isBefore(DateTime.now())) {
      prefs.clear();
      return false;
    }
    return true;
  }

// end
}
