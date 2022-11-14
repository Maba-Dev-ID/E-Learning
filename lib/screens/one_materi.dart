import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/helper/helper_materi.dart';
import 'package:flutter_application_1/providers/mapel_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_application_1/widget/modal_foto_widget.dart';
import 'package:provider/provider.dart';

class OneMateriScreen extends StatefulWidget {
  final String id;
  const OneMateriScreen(this.id, {super.key});

  @override
  State<OneMateriScreen> createState() => _OneMateriScreenState();
}

class _OneMateriScreenState extends State<OneMateriScreen> {
  bool isVisible = false;
  int navbar = 1;
  String? urlFoto;
  @override
  Widget build(BuildContext context) {
    var mapelProvider = Provider.of<MapelProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: AppBar(
        backgroundColor: kWhiteBg,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Materi"),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kGreenPrimary),
                onPressed: () {
                  mapelProvider.getfotoOtorisasi(urlFoto, context);
                },
                child: const Text("Lihat Foto ")),
          )
        ],
      ),
      body: Stack(children: [
        FutureBuilder(
          future: mapelProvider.getMateriById(widget.id, context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var d = snapshot.data['data'];
              urlFoto = snapshot.data['foto']['foto'];
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Card(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(d['judul'] ?? "Materi Undefined",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Kelas : ${d['kelas_mapel']['nama'] ?? 'Undefined'}",
                              style: TextStyle(fontSize: 12)),
                          Text("Mata Kuliah : ${d['mapel']['nama']}",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month),
                          Text(transLateday(d['created_at'] ?? "undefined"),
                              style: TextStyle(fontSize: 10)),
                          Text(showTimeAgo(d['created_at']),
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Deskripsi : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(
                          d['konten'],
                          overflow: !isVisible
                              ? TextOverflow.ellipsis
                              : TextOverflow.clip,
                          maxLines: !isVisible ? 10 : null,
                          textAlign: TextAlign.justify,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                              print(isVisible);
                            },
                            child: Text(
                                !isVisible ? "Selengkapnya" : "Lebih Sedikit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kGreenPrimary)))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              navbar = 1;
                            });
                          },
                          child: Text("Document ( ${d['file'].length} )")),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              navbar = 2;
                            });
                          },
                          child: Text(
                              "Video(${d['link_youtube'] == null ? '0' : '1'})"))
                    ],
                  ),
                  navbar == 1
                      ? Document(
                          documents: d['file'],
                          provider: mapelProvider,
                        )
                      : Container(),
                ],
              );
            }
          },
        ),
      ]),
    );
  }
}

class Document extends StatelessWidget {
  List? documents;
  MapelProvider provider;
  Document({
    Key? key,
    this.documents,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          documents!.length,
          (index) => GestureDetector(
                onTap: () async {
                  provider.getFileFromUrl(documents![index]['nama_file']);
                },
                child: Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    tileColor: kGreenPrimary,
                    leading: const Icon(
                      Icons.file_copy,
                      color: Colors.white,
                    ),
                    title: Text(
                      documents![index]['nama_file'],
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )),
    );
  }
}
