import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/providers/mapel_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:provider/provider.dart';

class TugasScreen extends StatelessWidget {
  const TugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var tugasAll = Provider.of<MapelProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: tugasAll.getTugas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var d = snapshot.data;
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: List.generate(
                    snapshot.data.length,
                    (index) => ListTile(
                          title: Text(d[index]['detail']['mapel']['nama']),
                          subtitle: Text(d[index]['detail']['judul']),
                          trailing: Text(
                              d[index]['detail']['tanggal_pengumpulan'],
                              style: TextStyle(color: kGreenPrimary)),
                        ))),
          );
        },
      ),
    ));
  }
}
