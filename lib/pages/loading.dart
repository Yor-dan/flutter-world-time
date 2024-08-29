import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    // lokasi dan waktu default
    WorldTime instance = WorldTime(
      location: 'Jakarta', flag: 'indonesia.png', url: 'Asia/Jakarta'
    );
    // request data waktu ke api
    await instance.getTime();
    // navigate ke home screen dengan data waktu yang didapat
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'phase': instance.phase
    });
  }

  @override
  void initState() {
    super.initState();
    // menjalankan fungsi ketika aplikasi pertama kali dibuka
    setupWorldTime();
  }

  // animasi loading
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 80.0,
        )
      )
    );
  }
}
