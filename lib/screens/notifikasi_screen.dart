import 'package:e_learning/helper/helper_materi.dart';
import 'package:e_learning/providers/notifikasi_provider.dart';
import 'package:e_learning/theme/theme.dart';
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
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data;
            return ListView(
              children: [
                Visibility(
                    visible: data['justnow'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: kGreenPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "hari Ini",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['justnow'].length,
                              (index) => Card(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(10),
                                      title: Text(
                                        "[MATERI] ${data['justnow'][index]['mapel']['nama']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      subtitle: Text(
                                        data['justnow'][index]['konten'],
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            transLateday(
                                              data['justnow'][index]
                                                  ['created_at'],
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Text(
                                            showTimeAgo(data['justnow'][index]
                                                ['created_at']),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    )),
                Visibility(
                    visible: data['yesterday'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: kGreenPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "Kemarin",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['yesterday'].length,
                              (index) => Card(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(10),
                                      title: Text(
                                        "[MATERI] ${data['yesterday'][index]['mapel']['nama']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                      subtitle: Text(
                                        data['yesterday'][index]['konten'],
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            transLateday(
                                              data['yesterday'][index]
                                                  ['created_at'],
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          Text(
                                            showTimeAgo(data['yesterday'][index]
                                                ['created_at']),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    )),
                Visibility(
                    visible: data['weekday'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: kGreenPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "Seminggu yang lalu",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['weekday'].length,
                              (index) => Card(
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        title: Text(
                                          "[MATERI] ${data['weekday'][index]['mapel']['nama']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        subtitle: Text(
                                          data['weekday'][index]['konten'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(
                                              transLateday(
                                                data['weekday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                            Text(
                                              showTimeAgo(
                                                data['weekday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ],
                                        )),
                                  )),
                        ),
                      ],
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
