import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../theme/theme.dart';

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
        // resizeToAvoidBottomInset: false,
        body: ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
            ),
            fit: BoxFit.cover,
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  FormLogin(
                      formKey: _formKey,
                      usernameCtrl: usernameCtrl,
                      passCtrl: passCtrl,
                      loginProvider: loginProvider)
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "E-learning",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
          ),
          Text(
            "Layanan Digitalisasi Sekolah",
            style: TextStyle(fontSize: 16, color: Color(0xFF06283D)),
          ),
        ],
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.usernameCtrl,
    required this.passCtrl,
    required this.loginProvider,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController usernameCtrl;
  final TextEditingController passCtrl;
  final UserProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Selamat Datang",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  color: Color(0xff256D85)),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextForm(usernameCtrl, 'Username'),
                          TextForm(
                            passCtrl,
                            'Password',
                            isObsecure: true,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kGreenPrimary),
                                onPressed: () {
                                  loginProvider.login(context,
                                      usernameCtrl.text, passCtrl.text);
                                },
                                child: const Text("Masuk")),
                          )
                        ]))
                  ]),
            ),
          ],
        ));
  }
}

class TextForm extends StatelessWidget {
  const TextForm(
    this.controller,
    this.hintText, {
    super.key,
    this.isObsecure,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? isObsecure;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        obscureText: isObsecure ?? false,
        controller: controller,
        decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            fillColor: const Color(0xffD9D9D9),
            filled: true,
            contentPadding: const EdgeInsets.all(15),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
