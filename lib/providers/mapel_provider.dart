import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/storaged.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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
    Uri url = Uri.parse(apiEndPoint['MATERIALL'] + "?perPage=100");

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      return result;
    } else {
      throw 'error get materi user';
    }
  }

  getMateriById(String id, context) async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERIALL'] + "/$id");
    print(url);
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body);
    if (result['status'] == 1) {
      return result['data'];
    } else {
      print(result);
      Navigator.pop(context);
      // throw 'error get materi user';
    }
  }

  getFileFromUrl(String url) async {
    try {
      url = "https://elearning.itg.ac.id/upload/materi/$url";
      print(Uri.parse(url));
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      Directory dir = await getApplicationDocumentsDirectory();
      print(dir);
      List<String> urlName = (url.toString()).split("/");
      String name = urlName[urlName.length - 1];
      File file = File("${dir.path}/$name");
      print(file);
      File urlFile = await file.writeAsBytes(bytes);
      await OpenFile.open(urlFile.path);
    } catch (e) {
      print(e);
      // throw Exception("Error opening url file");
    }
  }

  getMapel(
      String? idMapel, String? idRombel, String? isDone, String? pages) async {
    var token = await storage.read('token');
    var rombelId = "rombel_id=${idRombel ?? 'all'}";
    var mapelId = "mapel_id=${idMapel ?? 'all'}";
    var done = "is_done=${isDone ?? 'all'}";
    var page = "is_done=${pages ?? '1'}";
    Uri url =
        Uri.parse("${apiEndPoint['MAPEL']}?$mapelId&$rombelId&$done&$page");

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List result = (json.decode(response.body));
      Map<String, String> mapel = <String, String>{};

      for (var element in result) {
        mapel[element['nama']] = element['mapel_id'];
      }
      // print(mapel);
      return mapel;
    } else {
      throw 'error get materi user';
    }
  }
}
