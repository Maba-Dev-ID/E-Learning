import 'package:flutter/material.dart';

import '../theme/theme.dart';

PreferredSizeWidget? appbarWidget({String? title, BuildContext? context}) {
  return AppBar(
    title: Text(title ?? "", style: Theme.of(context!).textTheme.headline1),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    foregroundColor: Theme.of(context).primaryColor,
    toolbarHeight: 110,
    elevation: 0,
    centerTitle: true,
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
  );
}
