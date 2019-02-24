import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class PrestasiNonAkademikDetailMhs extends StatefulWidget {
  final String id;
  PrestasiNonAkademikDetailMhs({
    @required this.id
  });

  @override
  _PrestasiNonAkademikDetailMhsState createState() => _PrestasiNonAkademikDetailMhsState();
}

class _PrestasiNonAkademikDetailMhsState extends State<PrestasiNonAkademikDetailMhs> {
  bool loading = false;
  Map<String, dynamic> data = {};
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

    http.Response response = await http.get(urlApi + '/api/prestasi-non-akademik/list.php?id=' + widget.id);
    var body = jsonDecode(response.body);
    setState(() {
      data = body[0];
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
        title: Text('Detail Prestasi')
      ),
      body:  loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Prestasi Non Akademik', style: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 30.0),
              Text('Kegiatan', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['Kegiatan']),
              SizedBox(height: 20.0),
              Text('Tingkat', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['Tingkat']),
              SizedBox(height: 20.0),
              Text('Waktu Pelaksanaan', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['Waktu Pelaksanaan']),
              SizedBox(height: 20.0),
              Text('Hasil', style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor
              )),
              SizedBox(height: 10.0),
              Text(data['Hasil']),
              SizedBox(height: 20.0),
              FlatButton.icon(
                icon: Icon(Icons.attach_file),
                onPressed: () async {
                  File file = await _downloadFile(urlApi + '/files/' + data['Sertifikat'], data['Sertifikat']);
                  OpenFile.open(file.path);
                },
                color: Theme.of(context).primaryColor,
                label: Text('Sertifikat'),
                textColor: Colors.white
              )
            ],
          ),
        )
      )
    );
  }
}