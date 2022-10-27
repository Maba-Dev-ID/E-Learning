import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/storaged.dart';

import 'package:http/http.dart' as http;
import '../configs/apiEndPoint.dart';

class UserProvider extends ChangeNotifier {
  var storage = SecureStorage();
  login(context, String username, String password) async {
    Uri url = Uri.parse(apiEndPoint['LOGIN']);
    print(username);

    var response = await http.post(
      url,
      body: {"username": username, "password": password},
    );
    var result = jsonDecode(response.body);
    if (result['status'] == 1) {
      var token = result['token'];
      await storage.write('token', token);
      // await getProfileUser();

      showDialog(context: context, builder: (context) => loading());
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      });
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
    // print(result['senin'][0]['kelas_mapel']['mapel']['nama']);
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

      // var hari = mapel[0]['hari'];
      // var waktuMulai = mapel[0]['jam_mulai'];
      // var waktuSelesai = mapel[0]['jam_selesai'];
      // print(mapel[0]['kelas_mapel']['mapel']['nama']);
      // print("$hari , $waktuMulai - $waktuSelesai");
      print(mapel);
      return mapel;
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
        child: LinearProgressIndicator(),
      ),
    );
  }
}
