import 'dart:convert';
import 'dart:io';

import 'package:e_learning/helper/helper_materi.dart';
import 'package:e_learning/models/category.dart';
import 'package:e_learning/screens/one_materi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../configs/apiEndPoint.dart';
import '../services/storaged.dart';
import '../widget/modal_foto_widget.dart';

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
    var today = DateTime.now();
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

      String hari = await transLateday(today.toString());
      switch (hari) {
        case "Senin":
          return senin.isNotEmpty ? selasa : mapel;
        case "Selasa":
          return selasa.isNotEmpty ? selasa : mapel;
        case "Rabu":
          return rabu.isNotEmpty ? rabu : mapel;
        case "Kamis":
          return kamis.isNotEmpty ? kamis : mapel;
        case "Jumat":
          return jumat.isNotEmpty ? jumat : mapel;
        case "Sabtu":
          return sabtu.isNotEmpty ? sabtu : mapel;
        default:
          return mapel;
      }
    } else {
      throw 'error get profile user';
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
    List result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      result.sort(
        (a, b) => DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at'])),
      );
      return result;
    } else {
      throw 'error get profile user';
    }
  }

  getMateri(String? id) async {
    var token = await storage.read('token');
    Uri url = Uri.parse(
        apiEndPoint['MATERIALL'] + "?perPage=100&mapel_id=${id ?? ''}}");

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    List result = jsonDecode(response.body)['data'];
    if (response.statusCode == 200) {
      result.sort(
        (a, b) => DateTime.parse(b['created_at'])
            .compareTo(DateTime.parse(a['created_at'])),
      );
      return result;
    } else {
      throw 'error get materi user';
    }
  }

  validationMateri(String id, context) async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERIALL'] + "/$id");
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body);
    if (result['status'] == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OneMateriScreen(id)));
    } else {
      Navigator.pop(context);
    }
  }

  getMateriById(String id, context) async {
    var token = await storage.read('token');
    Uri url = Uri.parse(apiEndPoint['MATERIALL'] + "/$id");
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});
    var result = jsonDecode(response.body);
    if (result['status'] == 1) {
      return result;
    } else {
      throw 'error materi';
    }
  }

  getfotoOtorisasi(url, context) async {
    url = await apiEndPoint['FOTO_ABSENSI'] + url;
    showDialog(
        context: context, builder: (context) => ModalFotoWidget(url: url));
  }

  getFileFromUrl(String url) async {
    try {
      url = "https://elearning.itg.ac.id/upload/materi/$url";
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      Directory dir = await getApplicationDocumentsDirectory();
      List<String> urlName = (url.toString()).split("/");
      String name = urlName[urlName.length - 1];
      File file = File("${dir.path}/$name");
      File urlFile = await file.writeAsBytes(bytes);
      await OpenFile.open(urlFile.path);
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  getMapel(String? idMapel, String? isDone) async {
    var token = await storage.read('token');
    var mapelId = "mapel_id=${idMapel ?? 'all'}";
    var done = "is_done=${isDone ?? 'all'}";
    Uri url = Uri.parse("${apiEndPoint['MAPEL']}?$mapelId&$done&");

    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List result = (jsonDecode(response.body));
      result.insert(0, {"mapel_id": "all", "nama": "semua"});
      List<Category> category = result.map((e) {
        return Category.fromJson(e);
      }).toList();
      return category;
    } else {
      throw 'error get materi user';
    }
  }
}
