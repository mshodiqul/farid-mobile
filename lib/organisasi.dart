import 'package:flutter/material.dart';
import './detail-mahasiswa.dart';

class Organisasi extends StatefulWidget {
  _OrganisasiState createState() => _OrganisasiState();
}

class _OrganisasiState extends State<Organisasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Organisasi'),
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
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (_) => DetailMahasiswa(nim: '2888')
                      // ));
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