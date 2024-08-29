import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  //pilihan lokasi berupa list
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'assets/greece.png'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'assets/thailand.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'assets/germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'assets/egypt.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'assets/usa.png'),
    WorldTime(url: 'Asia/Dubai', location: 'Dubai', flag: 'assets/uae.png'),
    WorldTime(url: 'Europe/Istanbul', location: 'Istanbul', flag: 'assets/turkey.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'assets/indonesia.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'assets/uk.png'),
    WorldTime(url: 'Europe/Madrid', location: 'Madrid', flag: 'assets/spain.png'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'assets/russia.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'assets/kenya.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'assets/usa.png'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'assets/france.png'),
    WorldTime(url: 'Asia/Riyadh', location: 'Riyadh', flag: 'assets/arab.png'),
    WorldTime(url: 'Europe/Rome', location: 'Rome', flag: 'assets/italy.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'assets/south-korea.png'),
    WorldTime(url: 'Asia/Shanghai', location: 'Shanghai', flag: 'assets/china.png'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: 'assets/australia.png'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'assets/japan.png'),
  ];

  // function untuk memperbarui data
  void updateTime(index) async {
    // lokasi yang dipilih
    WorldTime instance = locations[index];
    // request data waktu ke api
    await instance.getTime();
    // kembali ke home screen dengan membawa data yang didapat
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'phase': instance.phase,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1.0,
              horizontal: 4.0
            ),
            // menampilkan list berupa card
            child: Card(
              child: ListTile(
                // kembali ke homescreen dengan data waktu yang baru
                onTap: () {
                  updateTime(index);
                },
                // nama lokasi
                title: Text(locations[index].location),
                // gambar bendera
                leading: CircleAvatar(
                  backgroundImage: AssetImage(locations[index].flag),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
