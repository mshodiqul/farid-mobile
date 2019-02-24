import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../config/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MahasiswaPrestasiAkademik extends StatefulWidget {
  _MahasiswaPrestasiAkademikState createState() => _MahasiswaPrestasiAkademikState();
}

class _MahasiswaPrestasiAkademikState extends State<MahasiswaPrestasiAkademik> {
  bool loading = false;
  bool editable = false;
  TextEditingController semester1 = new TextEditingController();
  TextEditingController semester2 = new TextEditingController();
  TextEditingController semester3 = new TextEditingController();
  TextEditingController semester4 = new TextEditingController();
  TextEditingController semester5 = new TextEditingController();
  TextEditingController semester6 = new TextEditingController();
  TextEditingController semester7 = new TextEditingController();
  TextEditingController semester8 = new TextEditingController();
  String selectedDosbing = '';

  Map<String, dynamic> data = {};
  String userId;

  String _pathFile1 = '';
  File _file1;
  String _pathFile2 = '';
  File _file2;
  String _pathFile3 = '';
  File _file3;
  String _pathFile4 = '';
  File _file4;
  String _pathFile5 = '';
  File _file5;
  String _pathFile6 = '';
  File _file6;
  String _pathFile7 = '';
  File _file7;
  String _pathFile8 = '';
  File _file8;

  List dosbing = [];

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

    http.Response response = await http.get(urlApi + '/api/prestasi-akademik/list.php?nim=' + userId);
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
        'status_1' : 'pending',
        'status_2' : 'pending',
        'status_3' : 'pending',
        'status_4' : 'pending',
        'status_5' : 'pending',
        'status_6' : 'pending',
        'status_7' : 'pending',
        'status_8' : 'pending'
      };
      loading = false;
    });

    await getDosbing();
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
    if (data['dosbing'] != null) {
      setState(() {
        selectedDosbing = data['dosbing'];
      });
    }
  }

  getDosbing() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/api/users/dosbing.php');
    var body = jsonDecode(response.body);
    setState(() {
      dosbing = body;
      loading = false;
    });

    dosbing.add({'nip_dosbing' : '0', 'nama' : 'Pilih Dosbing'});
    selectedDosbing = '0';
  }

  saveData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    Map<String, dynamic> dataToSend = {
      'nim' : userId,
      'nilai_semester_1' : semester1.text,
      'nilai_semester_2' : semester2.text,
      'nilai_semester_3' : semester3.text,
      'nilai_semester_4' : semester4.text,
      'nilai_semester_5' : semester5.text,
      'nilai_semester_6' : semester6.text,
      'nilai_semester_7' : semester7.text,
      'nilai_semester_8' : semester8.text,
      'dosbing' : selectedDosbing
    };

    if (_pathFile1.isNotEmpty) {
      data['file1_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file1_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile2.isNotEmpty) {
      data['file2_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file2_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile3.isNotEmpty) {
      data['file3_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file3_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile4.isNotEmpty) {
      data['file4_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file4_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile5.isNotEmpty) {
      data['file5_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file5_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile6.isNotEmpty) {
      data['file6_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file6_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile6.isNotEmpty) {
      data['file6_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file6_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile7.isNotEmpty) {
      data['file7_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file7_ext'] = _pathFile1.split('.').last;
    }
    if (_pathFile8.isNotEmpty) {
      data['file8_base64'] = base64Encode(_file1.readAsBytesSync());
      data['file8_ext'] = _pathFile1.split('.').last;
    }
  
    http.Response response = await http.post(urlApi + '/api/prestasi-akademik/edit.php', body: dataToSend);
    print(response.body);

    setState(() {
      loading = false;
      editable = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Success'),
        content: Text('Prestasi Anda Telah Di Edit'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ],
      )
    );
  }

  selectSertifikat(String path, File file) async {
    try {
      path = await FilePicker.getFilePath(type: FileType.ANY);
      setState(() {
        file = new File(path);
      });
    } catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestasi Akademik Anda')
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: editable ? Colors.green : Theme.of(context).primaryColor,
        child : !editable ? Icon(Icons.edit) : Icon(Icons.save),
        onPressed: () {
          if (editable) {
            saveData();
          } else {
            this.setState(() {
              editable = true;
            });
          }
        }
      ),
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
                Text('Pilih Dosbing'),
                SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedDosbing,
                      items: dosbing.map((value) {
                        return DropdownMenuItem(
                          value: value['nip_dosbing'],
                          child: Text(value['nama']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDosbing = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
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
                      try {
                        _pathFile1 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file1 = new File(_pathFile1);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    }
                  ),
                  Text(data['status_1'])
                ]),
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
                        _pathFile2 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file2 = new File(_pathFile2);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_2'])
                ]),
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
                        _pathFile3 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file3 = new File(_pathFile3);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_3'])
                ]),
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
                        _pathFile4 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file4 = new File(_pathFile4);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_4'])
                ]),
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
                        _pathFile5 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file5 = new File(_pathFile5);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_5'])
                ]),
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
                        _pathFile6 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file6 = new File(_pathFile6);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_6'])
                ]),
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
                        _pathFile7 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file7 = new File(_pathFile7);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }                      
                    },
                  ),
                  Text(data['status_7'])
                ]),
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
                        _pathFile8 = await FilePicker.getFilePath(type: FileType.ANY);
                        setState(() {
                          _file8 = new File(_pathFile8);
                        });
                      } catch (e) {
                        print("Unsupported operation" + e.toString());
                      }
                    },
                  ),
                  Text(data['status_8'])
                ]),
                SizedBox(height: 20.0),
              ]
          )
        )
      )
      )
    );
  }
}