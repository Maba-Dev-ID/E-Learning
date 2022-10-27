import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Task extends StatelessWidget {
  final total;
  final taskName;
  const Task({super.key, this.total, this.taskName});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 100,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(total,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
            Text(taskName),
          ],
        ),
      ),
    );
  }
}
