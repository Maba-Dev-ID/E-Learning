import 'dart:math';

import 'package:flutter/material.dart';

class KelasCard extends StatelessWidget {
  final namaMatakul;
  final jadwalMatkul;
  final index;
  const KelasCard({
    Key? key,
    this.namaMatakul,
    this.jadwalMatkul,
    this.index,
  }) : super(key: key);

  int? random() {
    var random = new Random();
    return random.nextInt(11);
  }

  @override
  Widget build(BuildContext context) {
    print(random());
    return Card(
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
                namaMatakul,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.access_time_rounded),
                Text('Selasa, 10:00-11:00', style: TextStyle(fontSize: 12))
              ],
            )
          ],
        ),
      ),
    );
  }
}
