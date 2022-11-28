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
    var notifikasiProvider =
        Provider.of<NotifikasiProvider>(context, listen: false);
    var theme = Theme.of(context);
    return Scaffold(
      appBar: appbarWidget(title: "Notifikasi", context: context),
      body: FutureBuilder(
        future: notifikasiProvider.getTugas(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data;
            return ListView(
              children: [
                //justnow
                Visibility(
                    visible: data['justnow'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Sebulan yang lalu",
                                style: theme.textTheme.headline3!
                                    .copyWith(color: theme.primaryColorDark)),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['justnow'].length,
                              (index) => Card(
                                    color: theme.primaryColorDark,
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        title: Text(
                                          "[TUGAS] ${data['justnow'][index]['detail']['mapel']['nama']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color:
                                                      theme.primaryColorLight),
                                        ),
                                        subtitle: Text(
                                          data['justnow'][index]['detail']
                                              ['judul'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: theme.primaryColorLight),
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
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                            Text(
                                              showTimeAgo(
                                                data['justnow'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                          ],
                                        )),
                                  )),
                        ),
                      ],
                    )),

                //yesterday
                Visibility(
                    visible: data['yesterday'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Sebulan yang lalu",
                                style: theme.textTheme.headline3!
                                    .copyWith(color: theme.primaryColorDark)),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['yesterday'].length,
                              (index) => Card(
                                    color: theme.primaryColorDark,
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        title: Text(
                                          "[TUGAS] ${data['yesterday'][index]['detail']['mapel']['nama']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color:
                                                      theme.primaryColorLight),
                                        ),
                                        subtitle: Text(
                                          data['yesterday'][index]['detail']
                                              ['judul'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: theme.primaryColorLight),
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
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                            Text(
                                              showTimeAgo(
                                                data['yesterday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                          ],
                                        )),
                                  )),
                        ),
                      ],
                    )),

                //weekday
                Visibility(
                    visible: data['weekday'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Sebulan yang lalu",
                                style: theme.textTheme.headline3!
                                    .copyWith(color: theme.primaryColorDark)),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['weekday'].length,
                              (index) => Card(
                                    color: theme.primaryColorDark,
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        title: Text(
                                          "[TUGAS] ${data['weekday'][index]['detail']['mapel']['nama']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color:
                                                      theme.primaryColorLight),
                                        ),
                                        subtitle: Text(
                                          data['weekday'][index]['detail']
                                              ['judul'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: theme.primaryColorLight),
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
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                            Text(
                                              showTimeAgo(
                                                data['weekday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                          ],
                                        )),
                                  )),
                        ),
                      ],
                    )),

                //monthday
                Visibility(
                    visible: data['monthday'].length > 0 ? true : false,
                    child: Column(
                      children: [
                        Container(
                          color: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text("Sebulan yang lalu",
                                style: theme.textTheme.headline3!
                                    .copyWith(color: theme.primaryColorDark)),
                          ),
                        ),
                        Column(
                          children: List.generate(
                              data['monthday'].length,
                              (index) => Card(
                                    color: theme.primaryColorDark,
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        title: Text(
                                          "[TUGAS] ${data['monthday'][index]['detail']['mapel']['nama']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                  color:
                                                      theme.primaryColorLight),
                                        ),
                                        subtitle: Text(
                                          data['monthday'][index]['detail']
                                              ['judul'],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: theme.primaryColorLight),
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(
                                              transLateday(
                                                data['monthday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
                                            ),
                                            Text(
                                              showTimeAgo(
                                                data['monthday'][index]
                                                    ['created_at'],
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: theme
                                                          .primaryColorLight),
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
