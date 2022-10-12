import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var nama;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future login(username, password) async {
    var url = Uri.parse("https://elearning.itg.ac.id/api/auth/login");

    Map data = {"username": username, "password": password};

    var response = await http.post(url, body: data);

    var result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(result['user']['detail']['nama']);
      print(result['user']['email']);
      print(result['user']['detail']['semester']);
      print(result['user']['detail']['nik']);
    }
  }

  Future cekTugas(token) async {
    var url =
        Uri.parse("https://elearning.itg.ac.id/api/student_area/dashboard");

    var response = await http.get(url, headers: {'bearer': token});

    print(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                login("2006132", "nokiaC10901");
              },
              child: Text("login"),
            ),
            ElevatedButton(
                onPressed: () {
                  cekTugas(
                      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDA3ZTBjOC1hZGM1LTRjYTMtYTU5MS1hMDQ1Y2I0NmJjZWEiLCJqdGkiOiJiY2JiNjI2MDM3NWExNmM0ZGUzNjQyYmU2YWNhMDUwODQyNzgyODU0OWE2ZjYwMTZiYjQ2ZWU2MGI0ZmI4NTViYTI1ODk1ZjNmNWVhNTA4MCIsImlhdCI6MTY2NTU2NDY3My42NDg4Mjk5MzY5ODEyMDExNzE4NzUsIm5iZiI6MTY2NTU2NDY3My42NDg4MzcwODk1Mzg1NzQyMTg3NSwiZXhwIjoxNjY1NjUxMDczLjQ3Mjk3NjkyMjk4ODg5MTYwMTU2MjUsInN1YiI6IjIwNzIiLCJzY29wZXMiOltdfQ.0-xZbdvTzPwTQlPULrr_0fYmmiW8WufQiy-muNHjDyymtU-nmaWelnHF62YwYsL6g4bXaKW7tzglXRjE-PuKCddD4f57VNrt2vhpU8BNtPY8vbcOOAkbArJTqqv8qqYz9PHIgfKs8HsecpWY8d8fo68NzvIR31nsbUmGfIs5vQ0NQgGgbMVplIFp7Z3oBEoB22RniEfIKU-24WXsmh0114uO2GkR2T5S1iPb9q1XY18zQ8v_5w6FkBO_8hUlW8pf6K7FxRRLlXtC8xdxCC9HovaGLQj7LBnPgxy-bA_JmloTy4I4J1JAbN3qWKERqXwqxWpmc561OU_aqHbngSSMIK37aDmou72GwjQPO5K0mjF3LUEA8eNWZrBPEwHVEQzOSdah7y0m-etQzHycJGlI3glIVYHumjN8wmPGOPs4sphJBDTH-o3bsY-bz-JT3TzqYjIcHsGXhkvc0ky45oVUVlaujGr_pFzEKaUF88qIUrDRKjm8wpBbB88F0HFG_xxG_BFJDGCObZZ1XBP_VOUGgixN6HZ9nyispB8QqYyt3QSaqtxo5Psqm1pUjjkVbli9V_rsokLqaP4Ada_audj3xUBOkEdr_x3gnEHyAQ3VUnWSTy7ych7j390WGp4lfiSyMK7277qOD6XPdMB6-fCLzoqLcSkCLZiSa-gEqmSs-eE');
                },
                child: Text("cek tuugas"))
          ],
        ),
      ),
    );
  }
}
