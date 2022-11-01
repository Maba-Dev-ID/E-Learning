import 'dart:async';

import 'package:flutter/src/material/expansion_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/loading.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/theme.dart';
import '../widget/profile.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({Key? key}) : super(key: key);

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
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
      appBar: appBarTugas(),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  expan(userProvider),
                ],
              ),
            )
          ],
        ),
      )
       
    );
  }

  PreferredSizeWidget appBarTugas() {
    return AppBar(
        backgroundColor: kWhiteBg,
        foregroundColor: Colors.black,
        toolbarHeight: 110,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tugas',
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xff06283D)),
        ));
  }

  Widget expan(UserProvider userProvider) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {},
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Kelas yang dipilih'),
            );
          },
          body: ListTile(
            title: Text(''),
            subtitle: Text('Details goes here'),
          ),
          isExpanded: true,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text('Status yang dicari'),
            );
          },
          body: ListTile(
            title: Text(''),
            subtitle: Text('Details goes here'),
          ),
          isExpanded: false,
        ),
      ],
    );
  }
}
