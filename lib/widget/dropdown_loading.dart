import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../theme/theme.dart';

class LoadingDropdown extends StatelessWidget {
  const LoadingDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Color.fromARGB(26, 0, 0, 0),
            offset: Offset(2, 5),
            blurRadius: 4)
      ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Pilih Mata Kuliah"),
          menuMaxHeight: 250,
          isExpanded: true,
          borderRadius: BorderRadius.circular(15),
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          items: [
            {"loading": "loading..."}
          ]
              .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
                  value: item.toString(),
                  child: Text(item['loading'].toString(),
                      style: const TextStyle(color: kGreen))))
              .toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
