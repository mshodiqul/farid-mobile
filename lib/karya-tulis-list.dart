import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import './config/api.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class KaryaTulisList extends StatefulWidget {
  final String nim;
  final String nama;

  KaryaTulisList({
    @required this.nim,
    @required this.nama
  });

  @override
  _KaryaTulisListState createState() => _KaryaTulisListState();
}

class _KaryaTulisListState extends State<KaryaTulisList> {
  bool loading = false;
  List data = [];

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

    http.Response response = await http.get(urlApi + '/api/karya-tulis/list.php?nim=' + widget.nim);
    var body = jsonDecode(response.body);
    setState(() {
      data = body;
      loading = false;
    });
  }

  Future<File> _downloadFile(String url, String filename) async {
      http.Client _client = new http.Client();
      var req = await _client.get(Uri.parse(url));
      var bytes = req.bodyBytes;
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karya Tulis Mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Karya Tulis Dari Mahasiswa', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text('Nama Mahasiswa : ${widget.nama}'),
              SizedBox(height: 5.0),
              Text('Nim : ${widget.nim}'),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 250,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, int index) {
                    Map<String, dynamic> d = data[index];

                    return ListTile(
                      title: Text(d['Judul']),
                      subtitle: Text(d['Bidang']),
                      trailing: FlatButton.icon(
                        color: Theme.of(context).primaryColor,
                        icon: Icon(Icons.attach_file, size: 16.0),
                        textColor: Colors.white,
                        onPressed: () async {
                          File file = await _downloadFile(urlApi + '/files/' + d['Berkas'], d['Berkas']);
                          OpenFile.open(file.path);
                        },
                        label: Text('Berkas', style: TextStyle(
                          fontSize: 10.0
                        )),
                      ),
                    );
                  },
                ),
              )
            ]
          )
        )
      )
    );
  }
}