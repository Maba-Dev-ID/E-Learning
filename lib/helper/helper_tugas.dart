import 'package:flutter/material.dart';

changeColor(isDone, tglUpload, deadline) {
  if (tglUpload != null) {
    var ddline = deadline.replaceAll(RegExp("-|:| "), "");
    var tglUp = tglUpload.replaceAll(RegExp("-|:| "), "");
    if (int.parse(tglUp) >= int.parse(ddline)) {
      return Colors.yellow;
    }
  } else if (isDone == "n") {
    return Colors.red;
  }
  return Colors.greenAccent;
}

splitTanggal(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[0];
}

splitWaktu(tanggal) {
  var isSplit = tanggal.split(' ');
  return isSplit[1];
}
