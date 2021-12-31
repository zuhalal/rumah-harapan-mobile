import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:update_covid/cardHarapan.dart';
import 'dart:convert' as convert;

import 'models/harapan.dart';

class HarapanUC extends StatefulWidget {
  // const HarapanUC({Key? key}) : super(key: key);
  static const routeName = '/updateCovid/harapan';

  final _formKey = GlobalKey<FormState>();

  @override
  _HarapanUCState createState() => _HarapanUCState();
}

class _HarapanUCState extends State<HarapanUC> {
  List<dynamic> responseJson = [];
  List<dynamic> jsonHarapan = [];
  List<Harapan> listHarapan = [];
  String harapan = "";
  DateTime waktu = DateTime.now();
  Map<String, int> userPK = new Map();
  Map<int, String> userName = new Map();

  userData() async {
    final request = context.watch<CookieRequest>();
    // print("object");
    try {
      final response = await request
          .get('https://rumah-harapan.herokuapp.com/updateCovid/jsonUser');
      // print(json + "ini");
      // print(responseJson);
      for (var user in response) {
        // print(user);
        // print(user['pk']);
        userPK[user['fields']['username']] = user['pk'];
        userName[user['pk']] = user['fields']['username'];
      }
      // print(userName);
      // print(userPK);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchData() async {
    final request = context.watch<CookieRequest>();
    await userData();
    try {
      listHarapan = [];
      final res = await request
          .get('https://rumah-harapan.herokuapp.com/updateCovid/jsonHarapan');
      int len = res.length;
      for (int i = 0; i < len; i++) {
        Fields fields = Fields(
          author: res[i]['fields']['Author'],
          message: res[i]['fields']['Message'],
          publishedDate: DateTime.parse(res[i]['fields']['published_date']),
          like: new List<int>.from(res[i]['fields']['like']),
        );

        Harapan har = Harapan(
          model: res[i]['model'],
          pk: res[i]['pk'],
          fields: fields,
        );

        int lenHar = listHarapan.length;

        if (lenHar == 0) listHarapan.add(har);
        for (int j = 0; j < lenHar; j++) {
          // print(DateTime.parse(jsonHarapan[i]['fields']['published_date']).compareTo(DateTime.parse(jsonHarapan[j]['fields']['published_date'])));
          if (har.fields.publishedDate
                  .compareTo(listHarapan[j].fields.publishedDate) >
              0) {
            listHarapan.insert(j, har);
            break;
          }
        }
      }
      // print(DateTime.parse(responseJson[0]['fields']['published_date']).toLocal());
      return;
    } catch (error) {
      print(error);
    }
    // print(userName);
    // print(userPK);
  }

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          // Here you told Flutter to use the word "snapshot".
          if (snapshot.connectionState == ConnectionState.waiting)
            return SizedBox(
              width: double.infinity,
              child: Container(
                color: const Color(0xffade8f4),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            );
          else
            return Scaffold(
              body: Column(
                children: [
                  Flexible(
                      child: SingleChildScrollView(
                    child: Container(
                      color: const Color(0xffade8f4),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                            child: Column(
                          children: [
                            Text(
                              'Kotak Harapan',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Color.fromRGBO(89, 165, 216, 1)),
                            ),
                            Text(
                              " ",
                            ),
                            Column(
                                children: listHarapan
                                    .map((list) => CardHarapan(
                                          data: list,
                                          userPk: userPK,
                                          userName: userName,
                                        ))
                                    .toList())
                          ],
                        )),
                      ),
                    ),
                  )),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color.fromRGBO(2, 62, 128, 1),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return request.loggedIn == true
                            ? AlertDialog(
                                content: Stack(
                                  clipBehavior: Clip.none,
                                  children: <Widget>[
                                    Positioned(
                                      right: -50.0,
                                      top: -50.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Form(
                                      key: widget._formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextFormField(
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Tuliskan Harapan Kamu disini',
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Silahkan masukan harapan anda terlibih dahulu';
                                                }
                                                setState(() {
                                                  harapan = value;
                                                });
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                child: Text("Kirim"),
                                                onPressed: () async {
                                                  if (widget
                                                      ._formKey.currentState!
                                                      .validate()) {
                                                    harapan = harapan;
                                                    final response =
                                                        await request.postJson(
                                                            "https://rumah-harapan.herokuapp.com/updateCovid/addMobile",
                                                            convert.jsonEncode(<
                                                                String, String>{
                                                              'pesan': harapan,
                                                            }));
                                                    if (response['status'] ==
                                                        'success') {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content:
                                                            Text("Berhasil!"),
                                                      ));
                                                      Navigator.of(context)
                                                          .pop();
                                                      // Navigator.of(context).pop();
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            "Gagal silahkan coba lagi"),
                                                      ));
                                                    }
                                                  }
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : AlertDialog(
                                content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 110,
                                      // padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                                      child: Column(children: <Widget>[
                                        Text(
                                            "Silahkan login terlebih dahulu untuk menuliskan harapan",
                                            textAlign: TextAlign.center),
                                        Text(""),
                                        ElevatedButton(
                                          child: Text("Login"),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/login_screen");
                                          },
                                        )
                                      ]),
                                    ),
                                    Positioned(
                                      right: -50.0,
                                      top: -50.0,
                                      child: InkResponse(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ]));
                      });
                },
                child: const Icon(Icons.add),
              ),
            );
        });
  }
}
