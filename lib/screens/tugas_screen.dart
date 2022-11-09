import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../utils/theme.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({Key? key}) : super(key: key);

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  String? chosenValue;
  String? id;
  String? rombel;
  String? done;
  String? page;

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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              FutureBuilder(
                future: tugasAll.getMapel(id, rombel, done, page),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // print(snapshot.data);
                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      width: 200,
                      height: 50,
                      decoration: const BoxDecoration(color: Color(0xffeeeeee)),
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
                },
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
