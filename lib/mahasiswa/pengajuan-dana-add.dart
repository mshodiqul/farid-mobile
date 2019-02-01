import 'package:flutter/material.dart';

class MahasiswaPengajuanDanaTambah extends StatefulWidget {
  @override
  _MahasiswaPengajuanDanaTambahState createState() => _MahasiswaPengajuanDanaTambahState();
}

class _MahasiswaPengajuanDanaTambahState extends State<MahasiswaPengajuanDanaTambah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController keperluan = new TextEditingController();
  TextEditingController volume = new TextEditingController();

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
        content: Text('Pengajuan Dana Berhasil Kirim'),
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
        title: Text('Ajukan Dana Baru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Keperluan"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Keperluan Pengajuan Dana'
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: keperluan,
                ),
                SizedBox(height: 20.0),
                Text("Nominal Dana"),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Masukkan Nominal Yang Ingin Di Ajukan'
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nominal tidak boleh kosong';
                    }
                    return null;
                  },
                  controller: volume,
                ),
                SizedBox(height: 20.0),
                FlatButton.icon(
                  icon: Icon(Icons.cloud_upload),
                  textColor: Theme.of(context).primaryColor,
                  label: Text('Upload Nota', style: TextStyle(
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