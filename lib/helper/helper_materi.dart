import 'package:intl/intl.dart';

namaDosen(namadepan, gelar) {
  gelar ??= "";
  return namadepan + gelar;
}

transLateday(day) {
  var date = DateTime.parse(day);
  String day1 = DateFormat.EEEE().format(date);
  switch (day1) {
    case "Monday":
      return "Senin";
    case "Tuesday":
      return "Selasa";
    case "Wednesday":
      return "Rabu";
    case "Thursday":
      return "Kamis";
    case "Friday":
      return "Jumat";
    case "Saturday":
      return "Sabtu";
    case "Sunday":
      return "Minggu";
    default:
      return "Error";
  }
}

showTimeAgo(datetime) {
  var date = DateTime.parse(datetime);
  var hari = DateFormat('dd').format(date).toString(); //ubah tanggal
  var bulan = DateFormat('MMMM').format(date).toString();
  var tahun = DateFormat('y').format(date).toString(); //ubah years
  String? isBulan;
  switch (bulan) {
    case "January":
      isBulan = "Januari";
      break;
    case "February":
      isBulan = "Februari";
      break;
    case "March":
      isBulan = "Maret";
      break;
    case "April":
      isBulan = "April";
      break;
    case "May":
      isBulan = "Mei";
      break;
    case "June":
      isBulan = "Juni";
      break;
    case "July":
      isBulan = "Juli";
      break;
    case "August":
      isBulan = "Agustus";
      break;
    case "September":
      isBulan = "September";
      break;
    case "October":
      isBulan = "Oktober";
      break;
    case "November":
      isBulan = "November";
      break;
    case "December":
      isBulan = "Desember";
      break;
    default:
      break;
  }
  return "$hari, $isBulan $tahun";
}
