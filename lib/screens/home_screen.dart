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
                margin: EdgeInsets.only(top: 34),
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
        return Center(
          child: CircularProgressIndicator(),
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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
      ]);
    },
  );
}

Widget kelas(UserProvider userProvider) {
  return Container(
    margin: EdgeInsets.only(top: 30),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Daftar Kelas",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
              GestureDetector(
                  onTap: () {
                    userProvider.getMataKuliah();
                  },
                  child: Text('Lihat semua', style: TextStyle(fontSize: 12))),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20),
          height: 200,
          child: FutureBuilder(
            future: userProvider.getMataKuliah(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return KelasCard(
                    namaMatakul: snapshot.data[index]['kelas_mapel']['mapel']
                        ['nama'],
                  );
                },
              );
            },
          ),
        )
      ],
    ),
  );
}
