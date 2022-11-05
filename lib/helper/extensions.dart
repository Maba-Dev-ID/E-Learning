setNamaGelar(namadepan, gelar) {
  gelar ??= "";
  return namadepan + gelar;
}

setJadwal(hari, wMulai, wSelesai) {
  var waktuMulai = "";
  var waktuSelesai = "";
  for (var i = 0; i <= 4; i++) {
    waktuMulai += wMulai[i];
    waktuSelesai += wSelesai[i];
  }
  String? jadwal = "$hari , $waktuMulai- $waktuSelesai";
  return jadwal;
}

setDescription(desc) {
  var description = '';
  var d = desc.replaceAll("<p>", " ");
  var d2 = d.replaceAll("</p>", " ");
  print(d2);
  return d2;
}
