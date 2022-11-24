import 'package:e_learning/helper/helper_materi.dart';
import 'package:e_learning/providers/notifikasi_provider.dart';
import 'package:e_learning/utils/theme.dart';
import 'package:e_learning/widget/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List angka = [1, 2, 3, 4, 5, 6, 7];
    var notifikasiProvider =
        Provider.of<NotifikasiProvider>(context, listen: false);
    return Scaffold(
      appBar: appbarWidget(title: "Notifikasi"),
      body: FutureBuilder(
        future: notifikasiProvider.getMateri(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(">>>>>> ${snapshot.data}");
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var d = snapshot.data;
            DateTime today = DateTime.now();
            print(d.length);
            return SingleChildScrollView(
                child: Column(
              children: List.generate(d.length, (index) {
                String weekday = d[index]['created_at'];
                if (today
                    .toLocal()
                    .difference(DateTime.parse(d[index]['created_at']))
                    .isNegative) {
                  return ListTile(
                    title: Text(d[index]['mapel']['nama']),
                  );
                } else if (today.day ==
                        DateTime.parse(d[index]['created_at']).day &&
                    today.month ==
                        DateTime.parse(d[index]['created_at']).month &&
                    today.year == DateTime.parse(d[index]['created_at']).year) {
                  return Column(
                    children: [
                      Text("Yesterday"),
                      Text(d[index]['mapel']['nama']),
                    ],
                  );
                } else if (today
                        .difference(DateTime.parse(d[index]['created_at']))
                        .inDays <
                    20) {
                  return Text(
                    "${transLateday(weekday)} - ${showTimeAgo(d[index]['created_at'])} \n ${d[index]['mapel']['nama']}",
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  );
                } else {
                  return Divider();
                }
              }),
            ));
          }
        },
      ),
    );
  }
}
