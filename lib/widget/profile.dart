import 'package:e_learning/utils/theme.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;

  Profile({super.key, this.title, this.subtitle, this.icon});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: kWhiteBg))),
      child: ListTile(
        leading: Icon(icon, color: theme.primaryColorDark,),
        title: Text(title!, style: TextStyle(fontSize:15,fontWeight: FontWeight.bold, color: theme.primaryColorDark)),
        subtitle: Text(subtitle!, style: TextStyle(color: theme.primaryColorDark)),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xffeeeeee),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                ),
                Container(
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 45,
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffeeeeee),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          padding: const EdgeInsets.all(15),
        ),
        Column(
          children: [
            ListTile(
              leading: CircleAvatar(backgroundColor: Color(0xffeeeeee),
              ),
              title: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xffeeeeee)),
                height: 10, width: 100,),
            )
          ],
        )
      ],
    );
  }
}
