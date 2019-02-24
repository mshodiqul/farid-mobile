import 'dart:convert';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersetujuanDetail extends StatefulWidget {
  final String id;
  PersetujuanDetail({
    @required this.id
  });

  _PersetujuanDetailState createState() => _PersetujuanDetailState();
}

class _PersetujuanDetailState extends State<PersetujuanDetail> {
  bool loading = false;
  Map<String, dynamic> data = {};
  bool editable = false;
  TextEditingController semester1 = new TextEditingController();
  TextEditingController semester2 = new TextEditingController();
  TextEditingController semester3 = new TextEditingController();
  TextEditingController semester4 = new TextEditingController();
  TextEditingController semester5 = new TextEditingController();
  TextEditingController semester6 = new TextEditingController();
  TextEditingController semester7 = new TextEditingController();
  TextEditingController semester8 = new TextEditingController();

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

  Future<File> _downloadFile(String url, String filename) async {
      http.Client _client = new http.Client();
      var req = await _client.get(Uri.parse(url));
      var bytes = req.bodyBytes;
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
  }

  getData() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/list.php?nim=' + widget.id);
    var body = jsonDecode(response.body);
    setState(() {
      data = body.length > 0 ? body[0] : {
        'Nilai_Semester1' : '0',
        'Nilai_Semester2' : '0',
        'Nilai_Semester3' : '0',
        'Nilai_Semester4' : '0',
        'Nilai_Semester5' : '0',
        'Nilai_Semester6' : '0',
        'Nilai_Semester7' : '0',
        'Nilai_Semester8' : '0',
      };
      loading = false;
    });
    setData();
  }

  setData() {
    semester1.text = data['Nilai_Semester1'];
    semester2.text = data['Nilai_Semester2'];
    semester3.text = data['Nilai_Semester3'];
    semester4.text = data['Nilai_Semester4'];
    semester5.text = data['Nilai_Semester5'];
    semester6.text = data['Nilai_Semester6'];
    semester7.text = data['Nilai_Semester7'];
    semester8.text = data['Nilai_Semester8'];
  }

  terimaPengajuan() async {
    Navigator.of(context, rootNavigator: true).pop();

    setState(() {
      loading = true;
    });

    Map<String, dynamic> dataToSend = {
      'status' : 'diterima',
      'id' : data['id_prestasi_akademik']
    };

    http.Response response = await http.post(urlApi + '/api/prestasi-akademik/confirmasi.php', body: dataToSend);
    print(response.body);
    setState(() {
      loading = false;
    });
    Navigator.of(context).pop();
    // getData();
  }

  confirm(String semester, String status) async {
    bool confirmBtn = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi'),
        content: Text('Apakah Anda Yakin Ingin Mengubah status ini menjadi ${status}'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text('OK'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text('TIDAK'),
          ),
        ],
      )
    );

    if (confirmBtn) {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> dataToSend = {
        'status' : status,
        'id' : data['id_prestasi_akademik'],
        'semester' :semester
      };

      http.Response response = await http.post(urlApi + '/api/prestasi-akademik/confirmasi.php', body: dataToSend);
      print(response.body);
      setState(() {
        loading = false;
      });
    }
  }

  kirimPesan() async {
      setState(() {
        loading = true;
      });
      Map<String, dynamic> dataToSend = {
        'id' : data['id_prestasi_akademik']
      };

      http.Response response = await http.post(urlApi + '/api/prestasi-akademik/kirim-pesan.php', body: dataToSend);
      print(response.body);
      setState(() {
        loading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Prestasi Akademik'),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () {
            kirimPesan();
          },
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text('Kirim Pesan Ke Mahasiswa'),
        )
      ],
      body: loading ? Center(
          child: SizedBox(
            width: 100.0,
            height: 100.0,
            child: CircularProgressIndicator(),
          ),
        ) :  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Semester 1'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester1,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_1'], data['file_1']);
                      OpenFile.open(file.path);
                    }
                  ),
                  Text(data['status_1'])
                ]),
                data['status_1'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('1', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {

                      },
                    )
                  ],
                ) :Container(),
                SizedBox(height: 20.0),
                Text('Semester 2'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester2,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_2'], data['file_2']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_2']),
                ]),
                data['status_2'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('2', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('2', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 3'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester3,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_3'], data['file_3']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_3'])
                ]),
                data['status_3'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('3', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('3', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 4'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester4,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_4'], data['file_4']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_4'])
                ]),
                data['status_4'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('4', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('4', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 5'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester5,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_5'], data['file_5']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_5'])
                ]),
                data['status_5'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('5', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('5', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 6'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester6,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_6'], data['file_6']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_6'])
                ]),
                data['status_6'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('6', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('6', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 7'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester7,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_7'], data['file_7']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_7'])
                ]),
                data['status_7'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('7', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('7', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
                Text('Semester 8'),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      enabled: editable,
                      controller: semester8,
                      keyboardType: TextInputType.number
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.attach_file),
                    label: Text('File'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      try {
                        File file = await _downloadFile(urlApi + '/files/akademik-' + data['file_8'], data['file_8']);
                        OpenFile.open(file.path);
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_8'])
                ]),
                data['status_8'] != 'diterima' ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Terima'),
                      onPressed: () {
                        confirm('8', 'diterima');
                      },
                    ),
                    FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Tolak'),
                      onPressed: () {
                        confirm('8', 'ditolak');
                      },
                    )
                  ],
                ) : Container(),
                SizedBox(height: 20.0),
              ]
          )
        )
      )
      )
    );
  }
}