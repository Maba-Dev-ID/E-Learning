import 'package:flutter/material.dart';
class Task extends StatelessWidget {
  final String? total;
  final String? taskName;
  final Color? color;
  const Task({super.key, this.total, this.taskName, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 100,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(total ?? '',
                style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColorLight)),
            Text(taskName ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Theme.of(context).primaryColorLight),),
          ],
        ),
      ),
    );
  }
}
