import 'package:e_learning/utils/theme.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;

  Profile({super.key, this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: kWhiteBg))),
      child: ListTile(
        leading: Icon(icon, color: kWhiteBg,),
        title: Text(title!, style: const TextStyle(color: kWhiteBg, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle!, style: const TextStyle(color: kWhiteBg)),
      ),
    );
  }
}

class SkeltonProfile extends StatelessWidget {
  const SkeltonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 80,
          backgroundColor: Color(0xffeeeeee),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 20,
          width: 100,
          decoration: BoxDecoration(
            color: const Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 10,
          width: 80,
          decoration: BoxDecoration(
            color: const Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xff256D85),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 20,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 20,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 35,
              width: 150,
              decoration: BoxDecoration(
                color: const Color(0xffeeeeee),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
    ;
  }
}
