import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kritik_saran/models/get_kritik_saran.dart';
import 'package:kritik_saran/screens/kritik_saran_form.dart';
import 'package:kritik_saran/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/screens/login_screen.dart';

class KritikSaranHome extends StatefulWidget {
  static const routeName = '/kritikSaran';
  const KritikSaranHome({Key? key}) : super(key: key);

  @override
  _KritikSaranHomeState createState() => _KritikSaranHomeState();
}

class _KritikSaranHomeState extends State<KritikSaranHome> {
  List<GetKritikSaran> extractedData = [];
  bool isUser = false;

  fetchData() async {
    const url = "http://rumah-harapan.herokuapp.com/kritikSaran/json";

    try {
      extractedData = [];
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Fields fields = Fields(
          nama: data["fields"]["nama"],
          kritikSaran: data["fields"]["kritik_saran"],
          waktuPost: data["fields"]["waktu_post"],
        );

        GetKritikSaran kritiksaran = GetKritikSaran(
            model: data["model"], pk: data["pk"], fields: fields);
        extractedData.add(kritiksaran);
      }
      return extractedData;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final request = context.watch<CookieRequest>();
    request.username != "" ? isUser = true : isUser = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kritik Saran"),
      ),
      // body:
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
                      'Kritik dan Saran',
                      style: TextStyle(
                          fontSize: 32,
                          color: const Color(0xff59A5D8),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kami sangat menghargai keinginan Anda untuk membantu kami mengembangkan website yang lebih baik. Anda dapat memberikan kritik dan saran dengan menulis pesan melalui tombol di bawah ini.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
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
                                      builder: (context) => KritikSaranForm());
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
                                child: const Text('Tambahkan Kritik/Saran'),
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
                        'assets/images/kritik_saran/kritiksaran.png'),
                    width: 300,
                    height: 400,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Kritik dan Saran dari Pengguna',
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
                                  data.fields.nama,
                                  data.fields.kritikSaran,
                                  data.fields.waktuPost),
                              SizedBox(
                                height: 10,
                              ),
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
