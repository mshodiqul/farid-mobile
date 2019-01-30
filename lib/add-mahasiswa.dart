import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './config/api.dart' show urlApi;

class AddMahasiswa extends StatefulWidget {
  _AddMahasiswa createState() => _AddMahasiswa();
}

class _AddMahasiswa extends State<AddMahasiswa> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nim = TextEditingController();
  TextEditingController nama = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void submit() async {
    if (_formKey.currentState.validate()) {
      Map<String, dynamic> dataToSend = {
        'nim' : nim.text,
        'nama' : nama.text
      };

      http.Response response = await http.post(urlApi + '/api/mahasiswa/add-mahasiswa.php', body: dataToSend);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Berhasil Tambah Mahasiswa'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Mahasiswa Baru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nomor Induk Mahasiswa"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nomor Induk Mahasiswa'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nim tidak boleh kosong';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: nim,
                ),
                SizedBox(height: 20.0),
                Text("Nama"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nama Mahasiswa',
                  ),
                  controller: nama,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text('Setiap Menambah Mahasiswa Baru Akan secara otomatis membuat user baru dengan username nim dan password 000000'),
                SizedBox(height: 20.0),
                FlatButton(
                  child: Text('SIMPAN'),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: submit,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}