import 'dart:async';

import 'package:flutter/src/material/expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/appbar.dart';
import 'package:flutter_application_1/widget/loading.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/profile.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({Key? key}) : super(key: key);

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  splitTanggal(tanggal) {
    var isSplit = tanggal.split(' ');
    return isSplit[0];
  }

  splitWaktu(tanggal) {
    var isSplit = tanggal.split(' ');
    return isSplit[1];
  }

  changeColor(isDone, tglUpload, deadline) {
    if (tglUpload != null) {
      var ddline = deadline.replaceAll(RegExp("-|:| "), "");
      var tglUp = tglUpload.replaceAll(RegExp("-|:| "), "");
      if (int.parse(tglUp) >= int.parse(ddline)) {
        return Colors.yellow;
      }
    } else if (isDone == "n") {
      return Colors.red;
    }
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    String? _chosenValue;
    var tugasAll = Provider.of<MapelProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: kWhiteBg,
        appBar: appbarWidget("Tugas"),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _chosenValue,
                  isExpanded: true,
                  //elevation: 5,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    'Technopreneuship',
                    'matematika diskrit',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    _chosenValue ?? "Kelas yang dipilih",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
              ),
              FutureBuilder(
                future: tugasAll.getTugas(),
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
                                      bottom: 6, right: 10, left: 5, top: 6),
                                  elevation: 4,
                                  child: ListTile(
                                    // dense: true,
                                    minVerticalPadding: 20,
                                    title: Text(
                                        d[index]['detail']['mapel']['nama'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)),
                                    subtitle: Text(d[index]['detail']['judul'],
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            splitTanggal(d[index]['detail']
                                                ['tanggal_pengumpulan']),
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        Text(
                                            splitWaktu(d[index]['detail']
                                                ['tanggal_pengumpulan']),
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: 5,
                                          width: 30,
                                          color: changeColor(
                                              d[index]['is_done'],
                                              d[index]['tanggal_upload'],
                                              d[index]['detail']
                                                  ['tanggal_pengumpulan']),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
