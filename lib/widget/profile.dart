import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatelessWidget {
  final String? data;
  final String? value;

  const Profile({super.key, this.data, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$data", style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("$value"),
        const SizedBox(
          height: 10,
        ),
      ],
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
        Hero(
          tag: 'profile',
          child: const CircleAvatar(
            radius: 80,
            backgroundColor: Color(0xffeeeeee),
          ),
        ),
        SizedBox(
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
        SizedBox(
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
