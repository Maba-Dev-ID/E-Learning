import 'dart:ui';

import 'package:e_learning/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OneTugas extends StatefulWidget {
  final String id;
  const OneTugas(this.id, {super.key});

  @override
  State<OneTugas> createState() => _OneTugasState();
}

class _OneTugasState extends State<OneTugas> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhiteBg,
      appBar: AppBar(
        leadingWidth: 30,
        toolbarHeight: 70,
        elevation: 0,
        shadowColor: kWhiteBg,
        backgroundColor: kWhiteBg,
        foregroundColor: Colors.black,
        title: Text(
          "Tugas",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        children: [Container(
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xff256D85),
            
          ),
          margin: EdgeInsets.fromLTRB(250, 0, 20, 0),
          alignment: Alignment.center,
          child: Text("Lihat foto autorisasi",style: TextStyle(fontSize: 10,color: kWhiteBg),),
        ),
        Container(
          
        )]
      ),
    );
  }
}
