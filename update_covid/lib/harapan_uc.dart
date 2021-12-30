import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:update_covid/cardHarapan.dart';
import 'package:http/http.dart' as http;

import 'models/harapan.dart';

class HarapanUC extends StatefulWidget {
  // const HarapanUC({Key? key}) : super(key: key);
  
  final _formKey = GlobalKey<FormState>();

  @override
  _HarapanUCState createState() => _HarapanUCState();
}

class _HarapanUCState extends State<HarapanUC> {

  final cardColor = Color.fromRGBO(89, 165, 216, 1);
  final TextEditingController pesan = TextEditingController();
  List<dynamic> responseJson = [];
  List<Harapan> listHarapan = [];
  String harapan = "";
  DateTime waktu = DateTime.now();
  Map<String,int> userPK = new Map();
  Map<int,String> userName = new Map();

  userData() async {
    const url = 'http://rumah-harapan.herokuapp.com/updateCovid/jsonUser';
    // print("object");
    try {
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      responseJson = jsonDecode(json);
      // print(json + "ini");
      // print(responseJson);
      print("Ini Sukses");
      for (var user in responseJson) {
        // print(user);
        // print(user['pk']);
        userPK[user['fields']['username']] = user['pk'];
        userName[user['pk']] = user['fields']['username'];
      }
      print(userName);
      print(userPK);
    } catch (error) {
      print(error);
    }
  }
  
  Future <void> fetchData() async {
    const url = 'http://rumah-harapan.herokuapp.com/updateCovid/json';
    userData();
    try {
      listHarapan = [];
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      responseJson = jsonDecode(json);
      print("Sukses");
      int len = responseJson.length;
      for (int i = 0; i < len; i++) {
        Fields fields = Fields(
          author: responseJson[i]['fields']['Author'],
          message: responseJson[i]['fields']['Message'], 
          publishedDate: DateTime.parse(responseJson[i]['fields']['published_date']), 
          like: new List<int>.from(responseJson[i]['fields']['like']),
          );
        
        Harapan har = Harapan(
          model: responseJson[i]['model'], 
          pk: responseJson[i]['pk'], 
          fields: fields,
        );

        int lenHar = listHarapan.length;
  
        if (lenHar == 0) listHarapan.add(har);
        for (int j = 0; j < lenHar; j++) {
          // print(DateTime.parse(responseJson[i]['fields']['published_date']).compareTo(DateTime.parse(responseJson[j]['fields']['published_date'])));
          if (har.fields.publishedDate.compareTo(listHarapan[j].fields.publishedDate) > 0) {
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
    print(userName);
    print(userPK);
  }

  // void didChangeDependencies() {
  //   userData();
  //   print("Masook");
  //   super.didChangeDependencies();
  // }

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) { // Here you told Flutter to use the word "snapshot".
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else 
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Kotak Harapan',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Color.fromRGBO(89, 165, 216, 1)),
                  ),

                  Text(" ",),
                  
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: listHarapan.length,
                    itemBuilder: (ctx,index) {
                      return CardHarapan(data: listHarapan[index], userPk: userPK, userName: userName,); // isUser-nya nnti disesuaiin
                    },
                  ),
                ],
              ),
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromRGBO(2, 62, 128, 1),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return request.loggedIn == true ? 
                    AlertDialog(
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
                                    labelText: 'Tuliskan Harapan Kamu disini',
                                  ),
                                  validator: (value){
                                    if (value == null || value.isEmpty) {
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
                                    onPressed: () {
                                      if (widget._formKey.currentState!.validate()) {
                                        harapan = harapan;
                                        waktu = DateTime.now();
                                        print(harapan);
                                        print(waktu.toString());
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ) :
                    AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none, 
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 70,
                            // padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                            child: Column(
                              children : <Widget> [
                                Text("Silahkan login terlebih dahulu untuk menuliskan harapan",
                                  textAlign: TextAlign.center
                                ),
                                Text(""),
                                ElevatedButton(
                                  child: Text("Login"),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/login_screen");
                                  },
                                )
                              ]
                            ),
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
                          // Text("Silahkan login terlebih dahulu untuk menuliskan harapan"),
                          // Text(""),
                          // ElevatedButton(
                          //   child: Text("Login"),
                          //   onPressed: () {
                          //     Navigator.pushNamed(context, "/login_screen");
                          //   },
                          // ),
                          // Center(
                          //   children : <Widget> [
                          //     Text("Silahkan login terlebih dahulu untuk menuliskan harapan"),
                          //     Text(""),
                              // ElevatedButton(
                              //   child: Text("Login"),
                              //   onPressed: () {
                              //     Navigator.pushNamed(context, "/login_screen");
                              //   },
                          //     ),
                          //   ]
                          // ),
                        ]
                      )
                    );
                  }
                );
              },
              child: const Icon(Icons.add),
            ),
          );
      }
    );
  }
}