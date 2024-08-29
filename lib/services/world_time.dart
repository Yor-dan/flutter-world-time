import 'package:http/http.dart';// package untuk membuat request
import 'dart:convert';// package untuk mengubah response JSON menjadi map
import 'package:intl/intl.dart';// package untuk format waktu

class WorldTime {
  String location; //nama lokasi
  late String time; //waktu di lokasi tersebut
  String flag; //link gambar bendera di folder assets
  String url; //url api endpoint milik lokasi
  late String phase; //fase waktu (pagi, siang, sore, malam)

  WorldTime({required this.location, required this.flag, required this.url});

  //Mengambil data-data yang dibutuhkan dari api
  Future<void> getTime() async {
    try {
      //membuat request ke api
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));

      // mengubah response JSON menjadi map
      Map data = jsonDecode(response.body);

      //mendapatkan properti dari data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //membuat DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //menentukan fase waktu
      phase = 
        now.hour >= 6 && now.hour < 15 ? 'day' : 
        now.hour >= 15 && now.hour < 18 ? 'twilight' :
        'night';

      //memformat data waktu  
      time = DateFormat.jm().format(now);
    } catch (e) {
      //pesan error ketika data waktu gagal didapatkan
      time = 'could not get the time data';
    }
  }
}
