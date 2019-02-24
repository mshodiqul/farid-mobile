import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/api.dart' show urlApi;
import 'package:shared_preferences/shared_preferences.dart';

class MhsGantiPassword extends StatefulWidget {
  @override
  _MhsGantiPasswordState createState() => _MhsGantiPasswordState();
}

class _MhsGantiPasswordState extends State<MhsGantiPassword> {
  TextEditingController passwordBaru =TextEditingController();
  TextEditingController passwordBaruC =TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  onSubmit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString('userid');

    if (_formKey.currentState.validate()) {
      var data = {
        'id' : userId,
        'password' : passwordBaru.text
      };

      http.Response response = await http.post(urlApi + '/api/users/ganti-password.php', body: data);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Password Berhasil Di Ganti'),
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
        title: Text('Ganti Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Password Baru'),
                TextFormField(
                  controller: passwordBaru,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Nama Tidak Boleh Kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.0),
                Text('Konfirmasi Password Baru'),
                TextFormField(
                  controller: passwordBaruC,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Konfirmasi Password Baru Tidak Boleh Kosong';
                    } else if (value != passwordBaru.text) {
                      return 'Konfirmasi Password Tidak Sama';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text('Simpan Perubahan'),
                  textColor: Colors.white,
                  onPressed: onSubmit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}