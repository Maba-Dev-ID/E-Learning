import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';

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
          child: FutureBuilder(
            future: userProvider.getProfileUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return Container(
                padding: const EdgeInsets.all(34),
                child: Column(
                  children: [
                    navbar(context,snapshot.data['nama'], snapshot.data['semester'],
                        snapshot.data['avatar']),
                    hero(context),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

Widget navbar(BuildContext context, nama, semester, String? image) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$nama",
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          Text("Semester $semester")
        ],
      ),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/profile'),
        child: CircleAvatar(
          backgroundImage:
              NetworkImage("https://elearning.itg.ac.id/upload/avatar/${image}"),
        ),
      )
    ],
  );
}

Widget hero(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 30),
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
