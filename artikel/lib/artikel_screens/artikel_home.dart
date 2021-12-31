import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:artikel/artikel_models/get_artikel.dart';
import 'package:artikel/artikel_screens/form_artikel.dart';
import 'package:artikel/widget_artikel.dart';
import 'package:provider/src/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/screens/login_screen.dart';


class ArtikelHome extends StatefulWidget {
  static const routeName = "/artikel";
  const ArtikelHome({Key? key}): super(key:key);

  @override
  _ArtikelHomeState createState() => _ArtikelHomeState();
}

class _ArtikelHomeState extends State<ArtikelHome> {
  List<GetArtikel> extractedData = [];
  bool isUser = false;

  fetchData() async {
    const url = "http://rumah-harapan.herokuapp.com/artikel/json";

    try {
      extractedData = [];
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
    
      for (var data in jsonData) {
        Fields fields = Fields(
          author: data["fields"]["author"],
          title: data["fields"]["title"],
          body: data["fields"]["body"],
          date: data["fields"]["date"],
        );

        GetArtikel artikel = GetArtikel(
          model: data["model"], pk: data["pk"], fields: fields);
        extractedData.add(artikel);
      }
      return extractedData;
    } catch (error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel"),
      ),

      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: const Color(0xffade8f4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Artikel',
                      // textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 32, color: const Color(0xff59A5D8)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kami menyediakan media berupa artikel, yaitu karangan faktual yang dapat memberikan informasi-informasi menarik seputar topik-topik mengenai Covid-19 terhadap pembaca pada laman ini.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffade8f4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: const Color(0xffade8f4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Artikel',
                      // textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 32, color: const Color(0xff59A5D8)),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kami sangat menghargai keinginan Anda untuk membantu kami mengembangkan website yang lebih baik. Anda dapat memberikan kritik dan saran dengan menulis pesan melalui tombol di bawah ini.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffade8f4),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: isUser
                          ? [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    onPrimary: Colors.white,
                                    primary: const Color(0xff023E8A),
                                    side: BorderSide(
                                        width: 2,
                                        color: const Color(0xff023E8A)),
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 8, bottom: 8),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0))),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) => ArtikelForm());
                                  Navigator.push(context, route);
                                },
                                child: const Text('Tambahkan Kritik/Saran'),
                              ),
                            ]
                          : [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  primary: const Color(0xff023E8A),
                                  side: BorderSide(
                                      width: 2, color: const Color(0xff023E8A)),
                                  onPrimary: Colors.white,
                                  padding: EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 8),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0)),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Anda Belum Login',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                            'Silakan Login Untuk Menambahkan Kritik dan Saran',
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 20),
                                                    onPrimary: Colors.white,
                                                    primary:
                                                        const Color(0xff023E8A),
                                                    side: BorderSide(
                                                        width: 2,
                                                        color: const Color(
                                                            0xff023E8A)),
                                                    padding: EdgeInsets.only(
                                                        left: 12,
                                                        right: 12,
                                                        top: 8,
                                                        bottom: 8),
                                                    shape: new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                8.0))),
                                                onPressed: () => Navigator
                                                    .pushReplacementNamed(
                                                        context,
                                                        LoginScreen.routeName),
                                                child: Text("Login")),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                    fontSize: 20),
                                                primary: Colors.black12,
                                                onPrimary: Colors.white,
                                                side: BorderSide(
                                                    width: 2,
                                                    color: const Color(
                                                        0xff023E8A)),
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    right: 12,
                                                    top: 8,
                                                    bottom: 8),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(8.0)),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Batal'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text('Tambahkan Artikel'),
                              ),
                            ])),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffade8f4),
                    ),
                    child: new Image.asset(
                        'assets/images/artikel/artikel.png'),
                    width: 300,
                    height: 400,
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                          'Daftar Artikel',
                          style:
                              TextStyle(fontSize: 24, color: const Color(0xff59A5D8)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          

          // Container(
          //   child: FutureBuilder(
          //       future: fetchData(),
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         if (snapshot.data == null) {
          //           return Container(
          //             child: Center(
          //               child: Text("Loading..."),
          //             ),
          //           );
          //         } else {
          //           return Column(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: extractedData.map((data) {
          //                 return Column(
          //                   children: [
          //                     SizedBox(height: 20),
          //                     CardWidget(
          //                         data.fields.author,
          //                         data.fields.title,
          //                         data.fields.body,
          //                         data.fields.date),
          //                   ],
          //                 );
          //               }).toList());
          //         }
          //       }),
          // ),
              )],
      )]),
    );
  }
}