import 'package:flutter/material.dart';
import './karya-tulis-list.dart';

class KaryaTulisApp extends StatefulWidget {
  _KaryaTulisState createState() => _KaryaTulisState();
}

class _KaryaTulisState extends State<KaryaTulisApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Karya Tulis'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Pencarian Berdasarkan Nama',
                          border: OutlineInputBorder()
                        ),
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100.0,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (_, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('Muzaki'.substring(0,1)),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => KaryaTulisList(nim: '2018991820182')
                      ));
                    },
                    title: Text('Muzaki'),
                    subtitle: Text('NIM : 200192910102')
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}