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
      Map allDay;
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
        return DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at']));
      });
      allDay = {
        "justnow": justNow,
        "yesterday": yesterday,
        "weekday": weekday,
      };
      return allDay;
    } else {
      throw 'error get materi user';
    }
  }

  getTugas({String? mapelId, String? status}) async {
    mapelId = mapelId ?? 'all';
    status = status ?? 'all';
    var token = await storage.read('token');
    Uri url = Uri.parse(
        apiEndPoint['TUGASALL'] + "?mapel_id=$mapelId&is_done=$status");
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      List justNow = [];
      List yesterday = [];
      List weekday = [];
      List monthday = [];
      Map allDay;
      result.forEach((data) {
        if (today
            .toLocal()
            .difference(DateTime.parse(data['created_at']))
            .isNegative) {
          justNow.add(data);
        } else if (today.difference(DateTime.parse(data['created_at'])).inDays <
            2) {
          yesterday.add(data);
        } else if (today.difference(DateTime.parse(data['created_at'])).inDays <
            8) {
          weekday.add(data);
        } else if (today.difference(DateTime.parse(data['created_at'])).inDays <
            31) {
          monthday.add(data);
        }
      });

      weekday.sort((a, b) {
        return DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at']));
      });
      monthday.sort((a, b) {
        return DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at']));
      });
      allDay = {
        "justnow": justNow,
        "yesterday": yesterday,
        "weekday": weekday,
        "monthday": monthday
      };
      return allDay;
    } else {
      throw 'error get profile user';
    }
  }
}
