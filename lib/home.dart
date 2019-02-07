import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './dashboard.dart';
import './user.dart';
import './mahasiswa.dart';
import './add-user.dart';
import './add-mahasiswa.dart';
import './kegiatan.dart';
import './prestasi_akademik.dart';
import './prestasi-non-akademik.dart';
import './karya-tulis.dart';
import './pengajuan-dana.dart';
import './kegiatan-tambah.dart';
import './organisasi.dart';
import './laporan-semester.dart';
import './login.dart';

// MAHASISWA
import './mahasiswa/karya-tulis.dart';
import './mahasiswa/karya-tulis-tambah.dart';
import './mahasiswa/prestasi-akademik.dart';
import './mahasiswa/prestasi-non-akademik.dart';
import './mahasiswa/prestasi-non-akademik-add.dart';
import './mahasiswa/organisasi.dart';
import './mahasiswa/pengajuan-dana.dart';
import './mahasiswa/pengajuan-dana-add.dart';
import './mahasiswa/kegiatan.dart';
import './mahasiswa/dashboard.dart';
import './mahasiswa/data-mahasiswa.dart';
import './mahasiswa/profile.dart';
import './mahasiswa/organisasi-tambah.dart';

// DOSBING
import './dosbing/dashboard.dart';
import './dosbing/persetujuan.dart';

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
        '/login' : (_) => LoginApp(),
        '/dashboard' : (_) => DashboardApp(),
        '/user' : (_) => UserApp(),
        '/mahasiswa' : (_) => MahasiswaApp(),
        '/add-user' : (_) => AddUser(),
        '/add-mahasiswa' : (_) => AddMahasiswa(),
        '/kegiatan' : (_) => Kegiatan(),
        '/kegiatan/tambah' : (_) => KegiatanTambah(),
        '/prestasi-akademik' : (_) => PrestasiAkademik(),
        '/prestasi-non-akademik' : (_) => PrestasiNonAkademik(),
        '/karya-tulis' : (_) => KaryaTulisApp(),
        '/pengajuan-dana' : (_) => PengajuanDana(),
        '/organisasi' : (_) => Organisasi(),
        '/laporan-semester' : (_) => LaporanSemester(),

        '/mahasiswa/dashboard' : (_) => DashboardMahasiswaApp(),
        '/mahasiswa/data' : (_) => DataMahasiswa(),
        '/mahasiswa/user' : (_) => ProfileMahasiswa(),
        '/mahasiswa/prestasi-akademik' : (_) => MahasiswaPrestasiAkademik(),
        '/mahasiswa/prestasi-non-akademik' : (_) => MahasiswaPrestasiNonAkademik(),
        '/mahasiswa/prestasi-non-akademik/add' : (_) => MahasiswaPrestasiNonAkademikTambah(),
        '/mahasiswa/organisasi' : (_) => MahasiswaOrganisasi(),
        '/mahasiswa/organisasi/add' : (_) => OrganisasiTambah(),
        '/mahasiswa/pengajuan-dana' : (_) => MahasiswaPengajuanDana(),
        '/mahasiswa/pengajuan-dana/add' : (_) => MahasiswaPengajuanDanaTambah(),
        '/mahasiswa/karya-tulis' : (_) => KaryaTulis(),
        '/mahasiswa/karya-tulis/tambah' : (_) => KaryaTulisTambah(),
        '/mahasiswa/kegiatan' : (_) => MahasiswaKegiatan(),

        '/dosbing/dashboard' : (_) => DashboardDosbing(),
        '/dosbing/persetujuan' : (_) => PersetujuanPrestasi()
      },
      initialRoute: '/',
    );
  }
}