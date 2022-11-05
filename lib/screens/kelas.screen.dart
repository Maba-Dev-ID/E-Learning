import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/mapel_provider.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/widget/appbar.dart';
import 'package:provider/provider.dart';

class KelasScreen extends StatefulWidget {
  const KelasScreen({super.key});

  @override
  State<KelasScreen> createState() => _KelasScreenState();
}

class _KelasScreenState extends State<KelasScreen> {
  var navigasi = false;
  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments;
    var mapelProvider = Provider.of<MapelProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: appbarWidget("Kelas"),
      body: FutureBuilder(
        future: mapelProvider.getMateriById(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          print(id);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(children: [
              Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: kGreenPrimary,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("",
                          style: TextStyle(
                              color: kWhiteBg,
                              fontSize: 24,
                              fontWeight: FontWeight.w700)),
                      const Text("Teknik Informatika - D",
                          style: TextStyle(color: kWhiteBg)),
                      const Text("Rabu, 12:00-13:00",
                          style: TextStyle(color: kWhiteBg, fontSize: 10)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                              color: kWhiteBg,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text("Fitri Nuraeni, S.Kom, M.Kom.",
                              style: TextStyle(
                                  color: kGreenPrimary, fontSize: 10)),
                        ),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        navigasi = true;
                      });
                    },
                    child: Text("Materi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              !navigasi ? FontWeight.w200 : FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        navigasi = false;
                      });
                    },
                    child: Text("Tugas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              !navigasi ? FontWeight.bold : FontWeight.w100,
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: List.generate(
                    10,
                    (index) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              bottom: 6, right: 10, left: 5, top: 6),
                          elevation: 4,
                          child: ListTile(
                            minVerticalPadding: 20,
                            title: Text("Materi 1 Gerbang Logika",
                                style: const TextStyle(
                                    color: kGreenPrimary,
                                    fontWeight: FontWeight.w700)),
                            subtitle: Text(
                                "Pelajari gerbang logika dari halaman 1 sampai dengan 2",
                                style: const TextStyle(
                                    color: kGreenPrimary, fontSize: 12)),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Selasa",
                                    style: const TextStyle(
                                        color: kGreenPrimary, fontSize: 12)),
                                Text("27-07-2022",
                                    style: const TextStyle(
                                        color: kGreenPrimary, fontSize: 12)),
                              ],
                            ),
                          ),
                        )),
              )
            ]);
          }
        },
      ),
    );
  }
}
