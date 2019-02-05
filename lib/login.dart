import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './config/api.dart' show urlApi;

class LoginApp extends StatefulWidget{
  LoginAppState createState()=>  LoginAppState();
}


class LoginAppState extends State<LoginApp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loggedIn = false;
  String ref = '';

  @override
  void initState() {
    super.initState();
    getLoggedIn();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('userid') != null) {
      if (preferences.getString('role') == 'mahasiswa') {
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentState.context, '/mahasiswa/dashboard', (Route<dynamic> route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(scaffoldKey.currentState.context, '/dashboard', (Route<dynamic> route) => false);
      }
      setState(() {
        loggedIn = true;
      });
    }
  }

  loading() {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text("Loading..."),
            )
          ],
        ),
      ),
    );
  }

  email() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
          filled: true,
          errorStyle: TextStyle(
            color: Colors.red
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            color: Theme.of(context).primaryColor
          ))
        ),
        controller: usernameController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Username Tidak Boleh Kosong';
          }
          return null;
        },
      ),
    );
  }

  password() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          fillColor: Colors.white,
          filled: true,
          errorStyle: TextStyle(
            color: Colors.red
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            color: Theme.of(context).primaryColor
          ))
        ),
        obscureText: true,
        controller: passwordController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Password Tidak Boleh Kosong';
          }
          return null;
        },
      ),
    );
  }

  void onLogin(BuildContext context) async {
    if (formKey.currentState.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return loading();
        }
      );

      // PROCESS SEND DATA
      Map<String, dynamic> dataToSend = {
        'username' : usernameController.text,
        'password' : passwordController.text
      };
      http.Response response = await http.post(urlApi + '/api/users/login.php', body: dataToSend);
      Navigator.of(context, rootNavigator: true).pop();

      print(response.body);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['status'] == 200) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('userid', body['user_id']);
          preferences.setString('role', body['role']);
          preferences.setString('nama', body['nama_user']);

          if (body['role'] == 'mahasiswa') {
            Navigator.pushNamedAndRemoveUntil(context, '/mahasiswa/dashboard', (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (Route<dynamic> route) => false);
          }
        } else {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Login Gagal'),
              content: Text(body['message']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                  child: Text('OK'),
                )
              ],
            )
          );
        }
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (BuildContext context) => new VerificationLogin(phone: usernameController.text, user: jsonDecode(response.body)['user'])
        // ));
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Terjadi Kesalahan Server'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                child: Text('OK'),
              )
            ],
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    PanelTitle(),
                    SizedBox(
                      height: 30.0,
                    ),
                    email(),
                    password(),
                    FlatButton(
                      onPressed: () {
                        onLogin(context);
                      },
                      child: SizedBox(
                        width: 250.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Theme.of(context).primaryColor
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Text("LOGIN SEKARANG", style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0
                          ), textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    SizedBox(
                      height : 10.0
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Hero(
          tag: 'logo-popay',
          child: Image.asset('assets/img/logo.png', width: 150.0),
        ),
      ],
    );
  }
}