import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/storaged.dart';
import 'package:http/http.dart' as http;

import '../configs/apiEndPoint.dart';

class MapelProvider extends ChangeNotifier {
  var storage = SecureStorage();

  getDashboard() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['DASHBOARD']);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      result as Map<String, dynamic>;
      return result;
    } else {
      throw 'error get profile user';
    }
  }

  addMapel(elements, list) {
    for (var element in elements) {
      list.add(element);
    }
  }

  getMataKuliah() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATAKULIAH']);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      result as Map<String, dynamic>;
      List mapelsenin = result['senin'];
      List mapelselasa = result['selasa'];
      List mapelrabu = result['rabu'];
      List mapelkamis = result['kamis'];
      List mapeljumat = result['jumat'];
      List mapelsabtu = result['sabtu'];
      List senin = [];
      List selasa = [];
      List rabu = [];
      List kamis = [];
      List jumat = [];
      List sabtu = [];

      addMapel(mapelsenin, senin);
      addMapel(mapelselasa, selasa);
      addMapel(mapelrabu, rabu);
      addMapel(mapelkamis, kamis);
      addMapel(mapeljumat, jumat);
      addMapel(mapelsabtu, sabtu);

      List mapel = [
        ...senin,
        ...selasa,
        ...rabu,
        ...kamis,
        ...jumat,
        ...sabtu,
      ];
      return mapel;
    } else {
      throw 'error get profile user';
    }
  }

  getTugas() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['TUGASALL']);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      return result;
    } else {
      throw 'error get profile user';
    }
  }

  getMateri() async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERIALL']);

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      return result;
    } else {
      throw 'error get materi user';
    }
  }

  getMateriById(id) async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERI_ID'] + id.toString());

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      return result;
    } else {
      throw 'error get materi user';
    }
  }
}
