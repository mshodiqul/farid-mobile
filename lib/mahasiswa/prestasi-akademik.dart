import 'package:flutter/material.dart';

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

  saveData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
      editable = false;
    });
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