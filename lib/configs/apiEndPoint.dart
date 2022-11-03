import 'package:flutter_application_1/configs/config.dart';

Map apiEndPoint = {
  "LOGIN": '$baseUrl/auth/login',
  "PROFILE": '$baseUrl/student_area/profile',
  "DASHBOARD": '$baseUrl/student_area/dashboard',
  "AVATAR": '$baseUrl/upload/avatar/',
  "MATAKULIAH": '$baseUrl/student_area/jadwal',
  "TUGASALL":
      '$baseUrl/student_area/tugas?judul=&rombel_id=all&mapel_id=all&is_done=all&page=1 ',
  //"MATERIALL": '$baseUrl/student_area/materi?manual_filter=0perPage=10&searchTerm=',
  "MATERIALL": '$baseUrl/student_area/materi?perPage=50',
};
