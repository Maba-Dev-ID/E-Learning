import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../configs/apiEndPoint.dart';
import '../services/storaged.dart';
import 'package:http/http.dart' as http;

class NotifikasiProvider extends ChangeNotifier {
  var storage = SecureStorage();
  DateTime today = DateTime.now();

  getMateri() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERIALL'] + "?perPage=100");

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      List justNow = [];
      List yesterday = [];
      List weekday = [];
      List allDay = [];
      result.forEach((data) {
        if (today
            .toLocal()
            .difference(DateTime.parse(data['created_at']))
            .isNegative) {
          justNow.add(data);
        } else if (today.day == DateTime.parse(data['created_at']).day &&
            today.month == DateTime.parse(data['created_at']).month &&
            today.year == DateTime.parse(data['created_at']).year) {
          yesterday.add(data);
        } else if (today.difference(DateTime.parse(data['created_at'])).inDays >
            2) {
          weekday.add(data);
        }
      });

      weekday.sort((a, b) {
        print("A >> $a");
        return DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at']));
      });
      allDay = [...justNow, ...yesterday, ...weekday];
      print("GET MATERI");
      print(allDay);
      return allDay;
    } else {
      throw 'error get materi user';
    }
  }
}
