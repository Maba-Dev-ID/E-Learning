import 'dart:math';

import 'package:flutter/material.dart';

class KelasCard extends StatelessWidget {
  final String? namaMatakul;
  final String? hari;
  final String? wMulai;
  final String? wSelesai;
  const KelasCard({
    Key? key,
    this.namaMatakul,
    this.hari,
    this.wMulai,
    this.wSelesai,
  }) : super(key: key);

  int? random() {
    var random = Random();
    return random.nextInt(11);
  }

  setJadwal(hari, wMulai, wSelesai) {
    var waktuMulai = "";
    var waktuSelesai = "";
    for (var i = 0; i <= 4; i++) {
      waktuMulai += wMulai[i];
      waktuSelesai += wSelesai[i];
    }
    String? jadwal = "$hari , $waktuMulai- $waktuSelesai";
    return jadwal;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      color: theme.primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 170,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/kelas/kelas${random()}.png',
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              child: Text(
                "$namaMatakul",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColorLight),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.access_time_rounded, color: theme.primaryColorLight,),
                Text(setJadwal(hari, wMulai, wSelesai),
                    style: TextStyle(fontSize: 12,color: theme.primaryColorLight))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SkeltonCard extends StatelessWidget {
  const SkeltonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffEEEEEE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 170,
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      ),
    );
  }
}
