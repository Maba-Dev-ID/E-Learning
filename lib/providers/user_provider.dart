import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/apiEndPoint.dart';
import '../services/storaged.dart';
import '../theme/theme.dart';

class UserProvider extends ChangeNotifier {
  var storage = SecureStorage();

  login(context, String username, String password) async {
    Uri url = Uri.parse(apiEndPoint['LOGIN']);
    print("$username Login");

    var response = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    var result = jsonDecode(response.body);
    showDialog(context: context, builder: (context) => loading());
    if (result['status'] == 1) {
      var token = result['token'];
      await storage.write('token', token);

      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              result['message'],
              textAlign: TextAlign.center,
            )));
      });
    }
  }

  logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = Theme.of(context);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Text("Yakin Keluar ?", style: theme.textTheme.headline3),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: theme.primaryColorLight),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tidak",
                      style: theme.textTheme.headline3,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor),
                    onPressed: () {
                      showDialog(
                          context: context, builder: (context) => loading());
                      Timer(const Duration(seconds: 2), () {
                        prefs.clear();
                        storage.deleteAll();
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/login", (route) => false);
                      });
                    },
                    child: Text(
                      "Ya",
                      style: theme.textTheme.headline3,
                    )),
              ],
            ));
  }

  Future<Map<String, dynamic>> getProfileUser() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['PROFILE']);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      result as Map<String, dynamic>;
      await storage.write('username', result['nama']);
      await storage.write('semester', result['semester']);
      return result;
    } else {
      throw 'error get profile user';
    }
  }

  Container loading() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: const Center(
        child: LinearProgressIndicator(
          color: kGreenPrimary,
          backgroundColor: kWhiteBg,
        ),
      ),
    );
  }
}
