import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/mapel_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:provider/provider.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({super.key});

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
    var tugasAll = Provider.of<MapelProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: kWhiteBg,
        appBar: AppBar(
          title: const Text("Tugas",
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
                                title: Text(d[index]['detail']['mapel']['nama'],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                subtitle: Text(d[index]['detail']['judul'],
                                    style:
                                        const TextStyle(color: Colors.white)),
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
        ));
  }
}
