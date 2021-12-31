import 'package:flutter/material.dart';
import '../cookies.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVision = false;
  void togglePassword() {
    setState(() {
      passwordVision = !passwordVision;
    });
  }

  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                    "Login",
                    style: TextStyle(
                      color: Color.fromRGBO(89, 165, 216, 1),
                      fontSize: 60,
                    ),
                  )),
              // buat tempat login
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 0.95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      onChanged: (String value) {
                        username = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(200, 200, 200, 1),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                  )),
              // buat tempat password
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 0.95),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        onChanged: (String value) {
                          password = value;
                        },
                        obscureText: !passwordVision,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                          ),
                          suffixIcon: IconButton(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            splashRadius: 1,
                            icon: Icon(passwordVision
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: togglePassword,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          return null;
                        },
                      ))),
              Container(
                child: Text(
                  "Belum punya akun? Register",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              // buat button
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(2, 62, 138, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color.fromRGBO(2, 62, 138, 1);
                        return null; // Defer to the widget's default.
                      }),
                    ),
                    onPressed: () async {
                      try {
                        final response =
                            await request.login("https://rumah-harapan.herokuapp.com/login2", {
                          'username': username,
                          'password': password,
                        });
                        print(response);
                        if (request.loggedIn) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response["message"]),
                            ),
                          );
                          Navigator.pushNamed(context, '/after_login');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response["message"]),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(2, 62, 138, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color.fromRGBO(2, 62, 138, 1);
                        return null; // Defer to the widget's default.
                      }),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/tabs_screen');
                    },
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
