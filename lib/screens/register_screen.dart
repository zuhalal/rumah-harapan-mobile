import 'package:flutter/material.dart';
import '../cookies.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVision = false;
  void togglePassword() {
    setState(() {
      passwordVision = !passwordVision;
    });
  }

  String username = "";
  String password1 = "";
  String password2 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Color.fromRGBO(89, 165, 216, 1),
            body: SingleChildScrollView(
              child: Container(
                height: 700,
                width: double.infinity,
                color: Colors.white,
                margin:
                    EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 70),
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          hintText: "Enter your username",
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            username = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            username = value!;
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        obscureText: !passwordVision,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter Password",
                          hintText: "Enter your password",
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
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            password1 = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            password1 = value!;
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        obscureText: !passwordVision,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Re-enter Password",
                          hintText: "Re-enter your password",
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
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            password2 = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            password2 = value!;
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: InkWell(
                        child: Text(
                          "Sudah punya akun? Login",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, '/login_screen'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(2, 62, 138, 1)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Color.fromRGBO(2, 62, 138, 1);
                            return null; // Defer to the widget's default.
                          }),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Submit to Django server and wait for response
                            final response = await request.postJson(
                                "https://rumah-harapan.herokuapp.com/register2",
                                convert.jsonEncode(<String, String>{
                                  'username': username,
                                  'password1': password1,
                                  'password2': password2,
                                }));
                            if (response['status'] == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response["message"]),
                                ),
                              );
                              Navigator.pushNamed(context, '/login_screen');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response["message"]),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(2, 62, 138, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
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
          ),
        ],
      ),
    );
  }
}