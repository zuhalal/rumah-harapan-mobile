import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  static const routeName = '/register_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(89, 165, 216, 1),
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(top: 70, right: 20, left: 20),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 60, bottom: 40),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Color.fromRGBO(89, 165, 216, 1),
                      fontSize: 60,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    hintText: "Enter your username",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Password",
                    hintText: "Enter your password",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Re-enter Password",
                    hintText: "Re-enter your password",
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Sudah punya akun? Login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Color.fromRGBO(2, 62, 138, 1),
                    child: Text("Register"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Akun Berhasil Dibuat"),
                            content: Text(nameController.text),
                            actions: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(
                                        context, '/tabs_screen');
                                  },
                                  child: new Text('OK'))
                            ],
                          );
                        },
                      );
                    },
                  )),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  color: Color.fromRGBO(2, 62, 138, 1),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/tabs_screen');
                  },
                  child: const Text('Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
