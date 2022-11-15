import 'package:flutter/material.dart';

changeIcon(isDone, tglUpload, deadline) {
  if (tglUpload != null) {
    var ddline = deadline.replaceAll(RegExp("-|:| "), "");
    var tglUp = tglUpload.replaceAll(RegExp("-|:| "), "");
    if (int.parse(tglUp) >= int.parse(ddline)) {
      return Icon(
        Icons.av_timer,
        color: Colors.yellow,
      );
    }
  } else if (isDone == "n") {
    return Icon(
      Icons.close_rounded,
      color: Colors.red,
    );
  }
  return Icon(Icons.check_circle_outline_outlined, color: Colors.lightGreen);
}

splitTanggal(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[0];
}

splitWaktu(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[1];
}
