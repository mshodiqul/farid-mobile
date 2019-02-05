import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class OrganisasiTambah extends StatefulWidget {
  @override
  _OrganisasiState createState() => _OrganisasiState();
}

class _OrganisasiState extends State<OrganisasiTambah> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaOrganisasi = TextEditingController();
  TextEditingController mulaiAktif = TextEditingController();
  TextEditingController akhirAktif = TextEditingController();
  TextEditingController jabatan = TextEditingController();
  
  File _fileSK;
  String _pathSK = '';
  String userId = '';

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
    setState(() {
      loading = false;
    });
  }

  selectSK() async {
    try {
      _pathSK = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        _fileSK = new File(_pathSK);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  submit() async {
    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'nama_organisasi' : namaOrganisasi.text,
      'mulai_aktif' : mulaiAktif.text,
      'akhir_aktif' : akhirAktif.text,
      'jabatan' : jabatan.text,
      'sk_base64' : base64Encode(_fileSK.readAsBytesSync()),
      'sk_ext' : _pathSK.split('/').last
    };
    http.Response response = await http.post(urlApi + '/api/organisasi/tambah.php', body: dataToSend);
    print(response.body);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Berhasil'),
        content: Text('Organisasi Berhasil Tambahkan'),
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
        title: Text('Tambah Riwayat Organisasi Baru'),
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
                Text("Nama Organisasi"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Organisasi'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Organisasi tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: namaOrganisasi,
                ),
                SizedBox(height: 20.0),
                Text("Mulai Aktif"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Mulai Aktif Organisasi'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Mulai Aktif tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: mulaiAktif,
                ),
                SizedBox(height: 20.0),
                Text("Akhir Aktif"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Akhir Aktif Organisasi'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Akhir Aktif tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: akhirAktif,
                ),
                SizedBox(height: 20.0),
                Text("Jabatan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Jabatan di Organisasi'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Jabatan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: jabatan,
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Sertifikat', style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  onPressed: selectSK,
                ),
                _pathSK.isNotEmpty ? Text(_pathSK) : Text('Sertifikat Belum Di Pilih'),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: submit,
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