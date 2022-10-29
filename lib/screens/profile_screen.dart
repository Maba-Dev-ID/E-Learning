import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/loading.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isTrue = true;
  loading() {
    Timer(const Duration(seconds: 1), () {
      isTrue = false;
    });
  }

  @override
  void initState() {
    loading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: appBarProfile(),
      body: profile(userProvider),
    );
  }
}

PreferredSizeWidget appBarProfile() {
  return AppBar(
      backgroundColor: kWhiteBg,
      foregroundColor: Colors.black,
      toolbarHeight: 110,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Profile',
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xff06283D)),
      ));
}

Widget profile(UserProvider userProvider) {
  return FutureBuilder(
    future: userProvider.getProfileUser(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (!snapshot.hasData) {
        return const SkeltonProfile();
      }
      var d = snapshot.data;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            foregroundImage: NetworkImage(
                "https://elearning.itg.ac.id/upload/avatar/${d['avatar']}"),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(d['nama'],
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const Text("Mahasiswa",
              style: TextStyle(fontSize: 12, color: Color(0xff06283D))),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff256D85),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "NIM : " + d['nim'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
                Text(
                  d["prodi"]["nama"],
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: [
                Profile(data: "Email", value: d['email']),
                Profile(
                  data: "Semester",
                  value: d['semester'],
                ),
                Profile(
                  data: "Tempat Lahir",
                  value: d['tempat_lahir'],
                ),
                Profile(
                  data: "Wali Dosen",
                  value: d['prodi']['nama_kajur'],
                )
              ],
            ),
          )
        ],
      );
    },
  );
}
