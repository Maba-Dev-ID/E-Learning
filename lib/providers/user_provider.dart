import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../configs/apiEndPoint.dart';

class UserProvider extends ChangeNotifier {
  login(context, String username, String password) async {
    print('username : $username');
    print('password : $password');
    Uri url = Uri.parse(apiEndPoint['LOGIN']);

    var response = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    var result = jsonDecode(response.body);
    print(response.statusCode);
    if (result['status'] == 1) {
      var token = result['token'];
      // await storage.write('token', token);
      // await getProfileUser();

      showDialog(context: context, builder: (context) => loading());
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false,
            arguments: result['user']['detail']['nama']);
      });
      print(token);
    } else {
      showDialog(context: context, builder: (context) => loading());
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            content: Text(
              'Email dan Password salah',
              textAlign: TextAlign.center,
            )));
      });
    }
  }

  Container loading() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 100,
      ),
      child: const Center(
        child: LinearProgressIndicator(),
      ),
    );
  }
}
