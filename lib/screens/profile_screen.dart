import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: AppBar(
          backgroundColor: kWhiteBg,
          foregroundColor: Colors.black,
          toolbarHeight: 110,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xff06283D)),
          )),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: Center(
              child: Text("Nama Lengkap",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ),
          Container(
            child: Center(
              child: Text("Fakultas Ilmu Komputer",
                  style: TextStyle(fontSize: 12, color: Color(0xff06283D))),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff256D85),
            ),
            margin: EdgeInsets.fromLTRB(45, 30, 45, 30),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "NIM : 2006132",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  "Teknik Informatika",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
