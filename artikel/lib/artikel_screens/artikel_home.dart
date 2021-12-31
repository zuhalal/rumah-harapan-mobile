import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:artikel/artikel_models/get_artikel.dart';
import 'package:artikel/artikel_screens/form_artikel.dart';
import 'package:artikel/widget_artikel.dart';

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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArtikelForm()));
                        },
                        child: Text('Tambahkan Artikel'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF023E8A),
                          onPrimary: Colors.white,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.only(
                              left: 12, right: 12, top: 8, bottom: 8),
                          fixedSize: const Size(460, 30),
                        ),
                      )
                    ],
                  )),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         color: const Color(0xffade8f4),
              //       ),
              //       child: new Image.asset(
              //           'assets/images/kritik_saran/kritiksaran.png'),
              //       width: 300,
              //       height: 400,
              //     ),
              //   ],
              // )
            ],
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

          Container(
            child: FutureBuilder(
                future: fetchData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading..."),
                      ),
                    );
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: extractedData.map((data) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              CardWidget(
                                  data.fields.author,
                                  data.fields.title,
                                  data.fields.body,
                                  data.fields.date),
                            ],
                          );
                        }).toList());
                  }
                }),
          ),
        ],
      ),
    );
  }
}