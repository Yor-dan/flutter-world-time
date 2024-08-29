import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // data yang akan ditampilkan pada home
  Map data = {};

  @override
  Widget build(BuildContext context) {
    // data yang didapat setelah request di loading screen
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    // menentukan gambar background sesuai fase waktu
    String bgImage = 
      data['phase'] == 'day' ? 'assets/bg/day.jpg' :
      data['phase'] == 'twilight' ? 'assets/bg/twilight.jpg' :
      'assets/bg/night.jpg';

    // menentukan warna background sesuai fase waktu
    Color bgColor = 
      data['phase'] == 'day' ? const Color(0xff008bd0) :
      data['phase'] == 'twilight' ? const Color(0xffffc876) :
      const Color(0xff262841);

    // menentukan warna font sesuai fase waktu
    Color fontColor =
      data['phase'] == 'day' ? const Color(0xfffafeff) :
      data['phase'] == 'twilight' ? const Color(0xff4a1623) :
      const Color(0xffe8e8e5);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                // routing menuju choose location screen
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  // memperbarui tampilan home dengan data yang baru
                  setState(() {
                    data = {
                      'location': result['location'],
                      'flag': result['flag'],
                      'time': result['time'],
                      'phase': result['phase'],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: fontColor,
                ),
                label: Text(
                  'Change location',
                  style: TextStyle(
                    color: fontColor,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: const Color(0xffe8e8e5),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(data['flag']),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28.0, letterSpacing: 2.0, color: fontColor
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(fontSize: 66.0, color: fontColor),
              )
            ],
          ),
        ),
      )),
    );
  }
}
