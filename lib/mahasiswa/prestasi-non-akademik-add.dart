import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class MahasiswaPrestasiNonAkademikTambah extends StatefulWidget {
  @override
  _PrestasiNonAkademikTambahState createState() => _PrestasiNonAkademikTambahState();
}

class _PrestasiNonAkademikTambahState extends State<MahasiswaPrestasiNonAkademikTambah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController kegiatan = new TextEditingController();
  TextEditingController waktupelaksaan = new TextEditingController();
  String tingkat = 'Provinsi';
  String hasil = 'Juara 1';

  bool loading = false;
  List data = [];
  String userId;
  String _pathSertifikat = '';
  File _fileSertifikat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('userid');
    print(userId);

    http.Response response = await http.get(urlApi + '/api/prestasi-non-akademik/list.php?nim=' + userId);
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
      loading = false;
    });
  }

  simpanPrestasi() async {
    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'kegiatan' : kegiatan.text,
      'tingkat' : tingkat,
      'waktu_pelaksanaan' : waktupelaksaan.text,
      'hasil' : hasil,
      'sertifikat_base64' : base64Encode(_fileSertifikat.readAsBytesSync()),
      'sertifikat_ext' : _pathSertifikat.split('.').last
    };

    http.Response response = await http.post(urlApi + '/api/prestasi-non-akademik/tambah.php', body: dataToSend);
    print(response.body);

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

  selectSertifikat() async {
    try {
      _pathSertifikat = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        _fileSertifikat = new File(_pathSertifikat);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Prestasi Baru'),
      ),
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
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
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text('Internasional'),
                          value: 'Nasional',
                        ),
                        DropdownMenuItem(
                          child: Text('Nasional'),
                          value: 'Nasional',
                        ),
                        DropdownMenuItem(
                          child: Text('Provinsi'),
                          value: 'Provinsi',
                        )
                      ],
                      onChanged: (v) {
                        setState(() {
                          kegiatan = v;
                        });
                      },
                      value: tingkat,
                    )
                  ),
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
                  controller: waktupelaksaan,
                ),
                SizedBox(height: 20.0),
                Text("Hasil"),
                SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text('Juara 1'),
                          value: 'Juara 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Juara 2'),
                          value: 'Juara 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Juara 3'),
                          value: 'Juara 3',
                        )
                      ],
                      onChanged: (v) {
                        setState(() {
                          hasil = v;
                        });
                      },
                      value: hasil,
                    )
                  ),
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Sertifikat', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: selectSertifikat,
                ),
                _pathSertifikat.isNotEmpty ? Text(_pathSertifikat) : Text('Sertifikat Belum Di Pilih'),
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