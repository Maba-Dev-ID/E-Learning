import 'dart:async';

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

  @override
  Widget build(BuildContext context) {
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
                        bottom: 6, right: 10, left: 5, top: 6),
                    elevation: 4,
                    child: ListTile(
                      minVerticalPadding: 20,
                      title: Text(d[index]['mapel']['nama'],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14)),
                      subtitle: Text(d[index]['judul'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10)),
                      trailing: Column(
                        children: [
                          SizedBox(
                            width: 68,
                            height: 20,
                            child: Text(d[index]['created_at'],
                            overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10
                                )),
                          ),
                          Text(
                            namaDosen(
                                d[index]['kelas_mapel']['guru']['nama'],
                                d[index]['kelas_mapel']['guru']
                                    ['gelar_belakang']),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
          },
        )));
  }
}
