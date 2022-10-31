import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/utils/theme.dart';
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
    OutlineInputBorder myfocusborder() {
      return OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none);
    }

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
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Elearning ITG",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Layanan Digitalisasi Sekolah",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF06283D)),
                      ),
                    ],
                  ),
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: const Text(
                            "Selamat Datang",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                color: Color(0xff256D85)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Form(
                                    key: _formKey,
                                    child: Column(children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          controller: usernameCtrl,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              isCollapsed: true,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              fillColor:
                                                  const Color(0xffD9D9D9),
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              hintText: 'Username',
                                              hintStyle: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: passCtrl,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none),
                                              fillColor:
                                                  const Color(0xffD9D9D9),
                                              filled: true,
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              hintText: 'Password',
                                              hintStyle: const TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ]))
                              ]),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        loginProvider.login(context,
                                            usernameCtrl.text, passCtrl.text);
                                      },
                                      child: const Text("Masuk"))),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
