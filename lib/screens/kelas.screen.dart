import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/extensions.dart';
import 'package:flutter_application_1/providers/mapel_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/widget/appbar.dart';
import 'package:provider/provider.dart';

class KelasScreen extends StatefulWidget {
  final argument;
  const KelasScreen({super.key, required this.argument});

  @override
  State<KelasScreen> createState() => _KelasScreenState();
}

class _KelasScreenState extends State<KelasScreen> {
  var navigasi = true;
  @override
  Widget build(BuildContext context) {
    var mapelProvider = Provider.of<MapelProvider>(context, listen: false);
    var data = widget.argument;
    var guru = data['kelas_mapel']['guru'];

    return Scaffold(
        backgroundColor: kWhiteBg,
        appBar: appbarWidget("Kelas"),
        body: ListView(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: kGreenPrimary,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['kelas_mapel']['mapel']['nama'],
                        style: const TextStyle(
                            color: kWhiteBg,
                            fontSize: 24,
                            height: 1.3,
                            fontWeight: FontWeight.w700)),
                    Text(data['kelas_mapel']['nama'],
                        style: TextStyle(color: kWhiteBg)),
                    Text(
                        setJadwal(data['hari'], data['jam_mulai'],
                            data['jam_selesai']),
                        style: TextStyle(color: kWhiteBg, fontSize: 10)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                            color: kWhiteBg,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            setNamaGelar(guru['nama'], guru['gelar_belakang']),
                            style: const TextStyle(
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
            navigasi
                ? Materi(
                    id: widget.argument['kelas_mapel']['mapel']['id']
                        .toString(),
                    mapelProvider: mapelProvider)
                : Text("Tugas"),
          ],
        ));
  }
}

class Materi extends StatelessWidget {
  final String id;
  final MapelProvider mapelProvider;
  const Materi({super.key, required this.id, required this.mapelProvider});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mapelProvider.getMateriById(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: List.generate(
                5,
                (index) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          bottom: 6, right: 10, left: 5, top: 6),
                      elevation: 2,
                      child: const ListTile(minVerticalPadding: 50),
                    )),
          );
        } else {
          return Column(
            children: List.generate(
                snapshot.data.length,
                (index) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      margin: const EdgeInsets.only(
                          bottom: 6, right: 10, left: 5, top: 6),
                      elevation: 4,
                      child: ListTile(
                        minVerticalPadding: 20,
                        title: Text(snapshot.data[index]['judul'],
                            style: const TextStyle(
                                color: kGreenPrimary,
                                fontWeight: FontWeight.w700)),
                        subtitle: Text(
                            setDescription(snapshot.data[index]['konten']),
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
          );
        }
      },
    );
  }
}
