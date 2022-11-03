import 'dart:async';
import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/src/material/expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/loading.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/profile.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  namaDosen(namadepan, gelar) {
    if (gelar == null) {
      gelar = "";
    }
    return namadepan + gelar;
  }

  showTimeAgo(datetime) {
  var date = DateTime.parse(datetime);
  var hari = DateFormat('dd').format(date).toString(); //ubah tanggal
  var bulan = DateFormat('MMMM').format(date).toString();
  var tahun = DateFormat('y').format(date).toString(); //ubah years
  var isBulan;
  print(bulan);
  switch (bulan) {
    case "January":
      isBulan = "Januari";
      break;
    case "February":
      isBulan = "Februari";
      break;
    case "March":
      isBulan = "Maret";
      break;
    case "April":
      isBulan = "April";
      break;
    case "May":
      isBulan = "Mei";
      break;
    case "June":
      isBulan = "Juni";
      break;
    case "July":
      isBulan = "Juli";
      break;
    case "August":
      isBulan = "Agustus";
      break;
    case "September":
      isBulan = "September";
      break;
    case "October":
      isBulan = "Oktober";
      break;
    case "November":
      isBulan = "November";
      break;
    case "December":
      isBulan = "Desember";
      break;
    default:
      print(isBulan);
      break;
  }
  return "${hari}, ${isBulan} ${tahun}";
}

  transLateday(day) {
    var date = DateTime.parse(day);
    String day1 = DateFormat.EEEE().format(date);
    switch (day1) {
      case "Monday":
        return "Senin";
      case "Tuesday":
        return "Selasa";
      case "Wednesday":
        return "Rabu";
      case "Thursday":
        return "Kamis";
      case "Friday":
        return "Jumat";
      case "Saturday":
        return "Sabtu";
      case "Sunday":
        return "Minggu";
      default:
        return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    // DateTime datetime = DateTime.now();
    // var DateFormat ;

    var materiAll = Provider.of<MapelProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: kWhiteBg,
        appBar: AppBar(
          title: const Text("Materi",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff06283D))),
          backgroundColor: kWhiteBg,
          foregroundColor: Colors.black,
          toolbarHeight: 110,
          elevation: 0,
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: materiAll.getMateri(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var d = snapshot.data;
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: List.generate(
                  snapshot.data.length,
                  (index) => Card(
                    color: kGreenPrimary,
                    margin: const EdgeInsets.only(
                        bottom: 6.0, right: 10.0, left: 5.0, top: 6.0),
                    elevation: 4,
                    child: ListTile(
                      minVerticalPadding: 15,
                      title: Text(d[index]['mapel']['nama'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          )),
                      subtitle: Text(d[index]['judul'],
                          style: const TextStyle(color: Colors.white)),
                      trailing: Container(
                        
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transLateday(d[index]['created_at'].toString()),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(showTimeAgo(d[index]['created_at'].toString()),
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            Container(
                              padding: EdgeInsets.fromLTRB(1.5, 1, 1.5, 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white70,
                              ),
                              child: Text(
                                namaDosen(
                                    d[index]['kelas_mapel']['guru']['nama'],
                                    d[index]['kelas_mapel']['guru']
                                        ['gelar_belakang']),
                                style: const TextStyle(color: Colors.black, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
          },
        )));
  }
}
