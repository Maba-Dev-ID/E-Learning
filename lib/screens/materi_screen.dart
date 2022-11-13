import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/one_materi.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../utils/theme.dart';
import '../helper/helper_materi.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({Key? key}) : super(key: key);

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  String? chosenValue;
  String? id;
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
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: SafeArea(
            child: ListView(
          children: [
            Container(
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
                  menuMaxHeight: 250,
                  borderRadius: BorderRadius.circular(15),
                  focusColor: Colors.white,
                  value: chosenValue,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  isExpanded: true,
                  selectedItemBuilder: (BuildContext context) {
                    return ["Matematika diskrit", "Fisika"].map<Widget>((item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        child: Text(item,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      );
                    }).toList();
                  },
                  items: ['M', "U", "Z"]
                      .map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TextStyle(color: Colors.black)),
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
                    });
                  },
                ),
              ),
            ),
            Container(
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
                  menuMaxHeight: 250,
                  borderRadius: BorderRadius.circular(15),
                  focusColor: Colors.white,
                  value: chosenValue,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  isExpanded: true,
                  selectedItemBuilder: (BuildContext context) {
                    return ["Matematika diskrit", "Fisika"].map<Widget>((item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        child: Text(item,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      );
                    }).toList();
                  },
                  items: ['M', "U", "Z"]
                      .map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  hint: Text(
                    chosenValue ?? "Waktu",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) {
                    setState(() {
                      print(value);
                      id = value;
                    });
                  },
                ),
              ),
            ),
            FutureBuilder(
              future: materiAll.getMateri(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                var d = snapshot.data;
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        children: List.generate(
                      snapshot.data.length,
                      (index) => GestureDetector(
                        onTap: () {
                          print(d[index]['id']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OneMateriScreen(
                                      d[index]['id'].toString())));
                        },
                        child: Card(
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
                                    fontSize: 14)),
                            subtitle: Text(d[index]['judul'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 13)),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  transLateday(
                                      d[index]['created_at'].toString()),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                    showTimeAgo(
                                        d[index]['created_at'].toString()),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    )),
                                Container(
                                  // padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white70,
                                  ),
                                  child: Text(
                                    namaDosen(
                                        d[index]['kelas_mapel']['guru']['nama'],
                                        d[index]['kelas_mapel']['guru']
                                            ['gelar_belakang']),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )));
              },
            ),
          ],
        )));
  }
}
