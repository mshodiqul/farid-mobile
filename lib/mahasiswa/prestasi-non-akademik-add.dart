import 'package:flutter/material.dart';

class MahasiswaPrestasiNonAkademikTambah extends StatefulWidget {
  @override
  _PrestasiNonAkademikTambahState createState() => _PrestasiNonAkademikTambahState();
}

class _PrestasiNonAkademikTambahState extends State<MahasiswaPrestasiNonAkademikTambah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController kegiatan = new TextEditingController();
  TextEditingController tingkat = new TextEditingController();
  TextEditingController waktu_pelaksaan = new TextEditingController();
  TextEditingController hasil = new TextEditingController();

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

  simpanPrestasi() async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Berhasil'),
        content: Text('Prestasi Berhasil Tambahkan'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop();
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Prestasi Baru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Kegiatan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Kegiatan'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Kegiatan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: kegiatan,
                ),
                SizedBox(height: 20.0),
                Text("Tingkat Prestasi"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Tingkatan Prestasi'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Tingkatan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: kegiatan,
                ),
                SizedBox(height: 20.0),
                Text("Waktu Pelaksaan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Waktu Pelaksaan'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Waktu Pelaksaan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: waktu_pelaksaan,
                ),
                SizedBox(height: 20.0),
                Text("Hasil"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Hasil Prestasi'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Kegiatan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: kegiatan,
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Sertifikat', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: () {

                  },
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: simpanPrestasi,
                    child: Text('SIMPAN', style: TextStyle(
                      color: Colors.white
                    )),
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}