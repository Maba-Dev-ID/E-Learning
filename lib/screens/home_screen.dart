import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/task.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/kelas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: kWhiteBg,
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 34),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    navbar(context, userProvider),
                    hero(context),
                    task(userProvider),
                  ],
                ),
              ),
              kelas(userProvider),
            ],
          ),
        ));
  }
}

Widget navbar(BuildContext context, UserProvider userProvider) {
  return FutureBuilder(
    future: userProvider.getProfileUser(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 100,
                  color: const Color(0xffEEEEEE),
                ),
                Container(
                  height: 10,
                  width: 50,
                  color: const Color(0xffEEEEEE),
                ),
              ],
            ),
            const CircleAvatar(
              backgroundColor: Color(0xffEEEEEE),
            )
          ],
        );
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${snapshot.data['nama']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
              Text("Semester ${snapshot.data['semester']}")
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://elearning.itg.ac.id/upload/avatar/${snapshot.data['avatar']}"),
            ),
          )
        ],
      );
    },
  );
}

Widget hero(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 30, bottom: 20),
    height: 166,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: kGreenPrimary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("ELearning ITG",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: kWhiteBg,
                    )),
                Text("Layanan Digitalisasi Sekolah",
                    style: TextStyle(color: kWhiteBg)),
              ],
            ),
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: kWhiteBg, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Silahkan Cari ...",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ))
                ],
              ),
            )
          ]),
    ),
  );
}

Widget task(UserProvider userProvider) {
  return FutureBuilder(
    future: userProvider.getDashboard(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        var size = MediaQuery.of(context).size;
        return Row(
            children: List.generate(
                3,
                (index) => const Task(
                      color: Color(0xffeeeeee),
                    )));
      }
      return Container(
        child: Row(children: [
          Task(
            taskName: "Materi",
            total: "${snapshot.data['materi']['total']}",
          ),
          Task(
            taskName: "Tugas",
            total: "${snapshot.data['tugas']['not_finished']}",
          ),
          Task(
            taskName: "Evaluasi",
            total: "${snapshot.data['evaluasi']['not_finished']}",
          )
        ]),
      );
    },
  );
}

Widget kelas(UserProvider userProvider) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Daftar Kelas",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
              GestureDetector(
                  onTap: () {},
                  child: const Text('Lihat semua',
                      style: TextStyle(fontSize: 12))),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: 200,
          child: FutureBuilder(
            future: userProvider.getMataKuliah(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) => const SkeltonCard()),
                  ),
                );
              }
              var data = snapshot.data;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      snapshot.data.length,
                      (index) => KelasCard(
                            namaMatakul: data[index]['kelas_mapel']['mapel']
                                ['nama'],
                            hari: data[index]['hari'],
                            wMulai: data[index]['jam_mulai'],
                            wSelesai: data[index]['jam_selesai'],
                          )),
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}
