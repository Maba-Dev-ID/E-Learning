import 'package:badges/badges.dart';
import 'package:e_learning/helper/helper_materi.dart';
import 'package:e_learning/screens/notifikasi_screen.dart';
import 'package:e_learning/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mapel_provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/kelas.dart';
import '../widget/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var mapelProvider = Provider.of<MapelProvider>(context, listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: kWhiteBg,
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
                    task(mapelProvider),
                  ],
                ),
              ),
              kelas(mapelProvider, context, today.toString()),
            ],
          ),
        ));
  }
}

Widget navbar(BuildContext context, UserProvider userProvider) {
  var theme = Theme.of(context);
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
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen())),
              child: const CircleAvatar(
                backgroundColor: Color(0xffEEEEEE),
              ),
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
                  style: theme.textTheme.headline3),
              Text(
                "${snapshot.data['user']['user_type'] == 'siswa' ? 'Mahasiswa' : snapshot.data['user']['user_type']}",
                style: theme.textTheme.subtitle1,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Badge(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotifikasiScreen()));
                    },
                    child: Icon(Icons.notifications)),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              data: snapshot.data,
                            ))),
                child: Hero(
                  tag: 'avatar',
                  child: CircleAvatar(
                    backgroundColor: const Color(0xffeeeeee),
                    backgroundImage: NetworkImage(
                        "https://elearning.itg.ac.id/upload/avatar/${snapshot.data['avatar']}"),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

Widget hero(BuildContext context) {
  var theme = Theme.of(context);
  return Container(
    margin: const EdgeInsets.only(top: 30, bottom: 20),
    height: 166,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: theme.primaryColor,
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
              children: [
                Text("E-Learning",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColorDark)),
                Text("Layanan Digitalisasi Sekolah",
                    style: TextStyle(color: theme.primaryColorDark)),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(
                        Icons.search,
                        color: kwhite,
                      ),
                    ),
                    Expanded(
                        child: Text("Silahkan Cari ...",
                            style: theme.textTheme.subtitle1))
                  ],
                ),
              ),
            )
          ]),
    ),
  );
}

Widget task(MapelProvider mapelProvider) {
  return FutureBuilder(
    future: mapelProvider.getDashboard(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return Row(
            children: List.generate(
                3,
                (index) => const Task(
                      color: Color(0xffeeeeee),
                    )));
      }
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/materi");
          },
          child: Task(
            taskName: "Materi",
            total: "${snapshot.data['materi']['total']}",
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/tugas");
          },
          child: Task(
            taskName: "Tugas",
            total: "${snapshot.data['tugas']['not_finished']}",
          ),
        ),
        Task(
          taskName: "Evaluasi",
          total: "${snapshot.data['evaluasi']['not_finished']}",
        )
      ]);
    },
  );
}

Widget kelas(MapelProvider mapelProvider, context, today) {
  var theme = Theme.of(context);
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Daftar Kelas",
                      style: TextStyle(
                          fontSize: 14, color: theme.primaryColorLight)),
                  TextSpan(
                      text: " Hari ${transLateday(today)} ",
                      style: TextStyle(
                          fontSize: 14,
                          color: theme.primaryColorLight,
                          fontWeight: FontWeight.bold))
                ]),
              ),
              GestureDetector(
                  onTap: () {},
                  child: Text('Lihat semua',
                      style: TextStyle(
                          fontSize: 14, color: theme.primaryColorLight))),
            ],
          ),
        ),
        Container(
          // padding: const EdgeInsets.only(left: 20),
          height: 200,
          child: FutureBuilder(
            future: mapelProvider.getMataKuliah(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
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
                      (index) => Container(
                            margin: index > 0
                                ? EdgeInsets.only(left: 5)
                                : EdgeInsets.only(left: 20),
                            child: KelasCard(
                              namaMatakul: data[index]['kelas_mapel']['mapel']
                                  ['nama'],
                              hari: data[index]['hari'],
                              wMulai: data[index]['jam_mulai'],
                              wSelesai: data[index]['jam_selesai'],
                            ),
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
