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
                horizontal: 70,
                vertical: MediaQuery.of(context).size.height / 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Masuk", style: Theme.of(context).textTheme.headline2),
                const SizedBox(height: 50),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            ),
          ),
        ],
      ),
    );
  }
}
