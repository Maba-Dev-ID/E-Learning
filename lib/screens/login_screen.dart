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
                horizontal: 50,
                vertical: MediaQuery.of(context).size.height / 4.5),
            child: Column(
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
                const SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text("Selamat Datang", style: TextStyle(fontSize: 15, color: Color(0xff256D85) ),),
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: usernameCtrl,
                            decoration:
                                InputDecoration(hintText: 'masukkan username'),
                          ),
                          TextFormField(
                            controller: passCtrl,
                            decoration:
                                InputDecoration(hintText: 'masukkan pasword'),
                          ),
                        ]))
                  ]),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          loginProvider.login(
                              context, usernameCtrl.text, passCtrl.text);
                        },
                        child: Text("Masuk"))),
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
