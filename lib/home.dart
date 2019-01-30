import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './dashboard.dart';
import './user.dart';
import './mahasiswa.dart';
import './add-user.dart';
import './add-mahasiswa.dart';
import './kegiatan.dart';
import './prestasi_akademik.dart';
import './organisasi.dart';
import './login.dart';

// MAHASISWA
import './mahasiswa/dashboard.dart';
import './mahasiswa/data-mahasiswa.dart';
import './mahasiswa/profile.dart';

class HomeApp extends StatefulWidget {
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  bool loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getLoggedIn() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // if (preferences.getString('userid') != null) {
    //   setState(() {
    //     loggedIn = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Bidik Misi',
      routes: {
        '/' : (_) => loggedIn ? DashboardApp() : LoginApp(),
        '/dashboard' : (_) => DashboardApp(),
        '/user' : (_) => UserApp(),
        '/mahasiswa' : (_) => MahasiswaApp(),
        '/add-user' : (_) => AddUser(),
        '/add-mahasiswa' : (_) => AddMahasiswa(),
        '/kegiatan' : (_) => Kegiatan(),
        '/prestasi-akademik' : (_) => PrestasiAkademik(),
        '/organisasi' : (_) => Organisasi(),
        '/mahasiswa/dashboard' : (_) => DashboardMahasiswaApp(),
        '/mahasiswa/data' : (_) => DataMahasiswa(),
        '/mahasiswa/user' : (_) => ProfileMahasiswa()
      },
      initialRoute: '/',
    );
  }
}