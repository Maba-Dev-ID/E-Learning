import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController passCtrl = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameCtrl.dispose();
    passCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: MediaQuery.of(context).size.height / 4.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Elearning ITG",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700 ),),
                Text(
                  "Layanan Digitalisasi Sekolah",
                  style: TextStyle(fontSize: 10, color: Color(0xFF06283D)),
                ),
                Card(                  
                  elevation: 5,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Text("Selamat Datang", style: TextStyle(fontFamily: "Poppins",fontSize: 25, color: Color(0xff256D85)),),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: TextFormField(
                              controller: usernameCtrl,
                              decoration:
                                  InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: Color(0xffD9D9D9),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.all(15),
                                    hintText: 'Username'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: TextFormField(
                              obscureText: true,
                              controller: passCtrl,
                              decoration:
                                  InputDecoration(
                                    border: OutlineInputBorder(),
                                    fillColor: Color(0xffD9D9D9),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.all(15),
                                    hintText: 'Password'),
                            ),
                          ),
                        ]))
                  ]),
                ),
                const SizedBox(height: 2),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 80,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {
                                loginProvider.login(
                                    context, usernameCtrl.text, passCtrl.text);
                              },
                              child: Text("Masuk"))),
                    ],
                  ),
                ),
              ],
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
