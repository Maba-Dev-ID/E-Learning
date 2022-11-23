import 'package:flutter/material.dart';

changeIcon(isDone, tglUpload, deadline) {
  if (tglUpload != null) {
    var ddline = deadline.replaceAll(RegExp("-|:| "), "");
    var tglUp = tglUpload.replaceAll(RegExp("-|:| "), "");
    if (int.parse(tglUp) >= int.parse(ddline)) {
      return Icon(
        Icons.av_timer,
        color: Colors.yellow,
        size: 20,
      );
    }
  } else if (isDone == "n") {
    return Icon(
      Icons.close_rounded,
      color: Colors.red,
      size: 20,
    );
  }
  return Icon(Icons.check_circle_outline_outlined, color: Colors.lightGreen,size: 20,);
}

splitTanggal(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[0];
}

splitWaktu(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[1];
}
