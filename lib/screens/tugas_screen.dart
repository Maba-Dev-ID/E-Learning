import 'package:e_learning/widget/dropdown_loading.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../helper/helper_tugas.dart';
import '../providers/mapel_provider.dart';
import '../utils/theme.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({Key? key}) : super(key: key);

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  List data = [
    {"key": "all", "value": "semua"},
    {"key": "y", "value": "selesai"},
    {"key": "n", "value": "belum selesai"},
  ];
  String? chosenValue;
  String? chosenStatus;
  bool isShowCategory = false;

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
              dropDownType(tugasAll),
              dropDownStatus(),
              if (isShowCategory)
                TugasAll(
                  tugasAll: tugasAll,
                  mapelId: chosenValue,
                  status: chosenStatus,
                ),
              if (!isShowCategory) TugasAll(tugasAll: tugasAll),
            ],
          ),
        ));
  }

  Widget dropDownType(tugasAll) {
    return FutureBuilder(
      future: tugasAll.getMapel(chosenValue, chosenStatus),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const LoadingDropdown();
        } else {
          List<DropdownMenuItem<String>> items = (snapshot.data)
              .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                  value: item.id,
                  child: Text(item.category, style: TextStyle(color: kGreen))))
              .toList();
          return Container(
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(26, 0, 0, 0),
                  offset: Offset(2, 5),
                  blurRadius: 4)
            ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text("Pilih Mata Kuliah"),
                menuMaxHeight: 250,
                isExpanded: true,
                borderRadius: BorderRadius.circular(15),
                value: chosenValue,
                style: const TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: items,
                onChanged: (value) {
                  setState(() {
                    isShowCategory = true;
                    chosenValue = value;
                  });
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget dropDownStatus() {
    List<DropdownMenuItem<String>> items = data
        .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
            value: item['key']!,
            child: Text(item['value']!,
                style: const TextStyle(
                  color: kGreen,
                ))))
        .toList();
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            offset: Offset(2, 5),
            blurRadius: 4)
      ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Pilih Status"),
          menuMaxHeight: 250,
          isExpanded: true,
          borderRadius: BorderRadius.circular(15),
          value: chosenStatus,
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: items,
          onChanged: (value) {
            setState(() {
              print(value);
              isShowCategory = true;
              chosenStatus = value;
              print(chosenStatus);
            });
          },
        ),
      ),
    );
  }
}

class TugasAll extends StatelessWidget {
  TugasAll({
    Key? key,
    this.mapelId,
    this.status,
    required this.tugasAll,
  }) : super(key: key);

  String? mapelId;
  String? status;
  final MapelProvider tugasAll;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tugasAll.getTugas(mapelId: mapelId, status: status),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: kGreenPrimary, size: 40),
              ),
            ],
          );
        }
        var d = snapshot.data;
        if (snapshot.data.length > 0) {
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
                                style: const TextStyle(color: Colors.white)),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    splitTanggal(d[index]['detail']
                                        ['tanggal_pengumpulan']),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11)),
                                Text(
                                    splitWaktu(d[index]['detail']
                                        ['tanggal_pengumpulan']),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11)),
                                changeIcon(
                                    d[index]['is_done'],
                                    d[index]['tanggal_upload'],
                                    d[index]['detail']['tanggal_pengumpulan']),
                              ],
                            ),
                          ),
                        ))),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              const Center(
                child: Text("Tugas tidak ditemukan :)"),
              ),
            ],
          );
        }
      },
    );
  }
}
