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
  String? chosenValue;
  String? id;
  String? rombel;
  String? done;
  String? page;
  namaDosen(namadepan, gelar) {
    gelar ??= "";
    return namadepan + gelar;
  }

  showTimeAgo(datetime) {
    var date = DateTime.parse(datetime);
    var hari = DateFormat('dd').format(date).toString(); //ubah tanggal
    var bulan = DateFormat('MMMM').format(date).toString();
    var tahun = DateFormat('y').format(date).toString(); //ubah years
    String? isBulan;
    // print(bulan);
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
    return "$hari, $isBulan $tahun";
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
            child: ListView(
          children: [
            FutureBuilder(
                future: materiAll.getMapel(id, rombel, done, page),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(26, 0, 0, 0),
                                offset: Offset(2, 5),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          menuMaxHeight: 250,
                          borderRadius: BorderRadius.circular(15),
                          focusColor: Colors.white,
                          value: chosenValue,
                          style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          selectedItemBuilder: (BuildContext context) {
                            return snapshot.data.keys.map<Widget>((item) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                constraints:
                                    const BoxConstraints(minWidth: 100),
                                child: Text(item,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              );
                            }).toList();
                          },
                          items: snapshot.data.values
                              .map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: TextStyle(color: Colors.black)),
                            );
                          }).toList(),
                          hint: Text(
                            chosenValue ?? "Kelas yang dipilih",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              id = value;
                              chosenValue = value;
                            });
                          },
                        ),
                      ),
                    );
                  }
  }),
                  // resizeToAvoidBottomPadding : false;
                  FutureBuilder(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            snapshot.data.length,
                            (index) => Card(
                              color: kGreenPrimary,
                              margin: const EdgeInsets.only(
                                  bottom: 6.0, right: 5.0, left: 5.0, top: 6.0),
                              elevation: 4,
                              child: ListTile(
                                  minVerticalPadding: 10,
                                  title: Text(d[index]['mapel']['nama'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  subtitle: Text(d[index]['judul'],
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        transLateday(
                                            d[index]['created_at'].toString()),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                          showTimeAgo(d[index]['created_at']
                                              .toString()),
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      Container(
                                        // padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                        // padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(10),
                                          color: Colors.white70,
                                        ),
                                        child: Text(
                                          namaDosen(
                                              d[index]['kelas_mapel']['guru']
                                                  ['nama'],
                                              d[index]['kelas_mapel']['guru']
                                                  ['gelar_belakang']),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          )));
  },)]),
        ));
  }
}