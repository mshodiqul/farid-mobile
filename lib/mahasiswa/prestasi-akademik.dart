import 'dart:convert';

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

  Map<String, dynamic> data = {};
  String userId;

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
      data = body.length > 0 ? body[0] : {};
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
    };
  
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prestasi Akademik Anda'),
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
                Text('Semester 1'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester1,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 2'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester2,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 3'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester3,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 4'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester4,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 5'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester5,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 6'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester6,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 7'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester7,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
                Text('Semester 8'),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: editable,
                  controller: semester8,
                  keyboardType: TextInputType.number
                ),
                SizedBox(height: 20.0),
              ]
          )
        )
      )
      )
    );
  }
}