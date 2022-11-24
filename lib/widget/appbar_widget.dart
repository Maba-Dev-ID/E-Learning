import 'package:flutter/material.dart';

import '../utils/theme.dart';

PreferredSizeWidget? appbarWidget({String? title}) {
  return AppBar(
    title: Text(title ?? "",
        style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xff06283D))),
    backgroundColor: kWhiteBg,
    foregroundColor: Colors.black,
    toolbarHeight: 110,
    elevation: 0,
    centerTitle: true,
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
  );
}
