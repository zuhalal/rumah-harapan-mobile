import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/widgets/main_drawer.dart';
import 'package:rumah_harapan/widgets/main_drawer_login.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/widgets/home_vaksin_container.dart';
import 'package:vaksin/widgets/forum_informasi_vaksin.dart';

class HomeVaksin extends StatefulWidget {
  static const routeName = '/vaksin';
  const HomeVaksin({Key? key}) : super(key: key);

  @override
  State<HomeVaksin> createState() => _HomeVaksinState();
}

class _HomeVaksinState extends State<HomeVaksin> {
  List<AllForum> extractedForumData = [];
  bool isUser = false;
  int totalsasaran = 0;
  int sasaransdmk = 0;
  String sasaranlansia = '';
  String sasaranpetugas = '';
  String dosis1 = '';
  String dosis2 = '';
  String lastUpdate = '';

  fetchDataKonten() async {
    const url = 'http://rumah-harapan.herokuapp.com/vaksin/all_forum';

    try {
      extractedForumData = [];
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Fields fields = Fields(
            judul: data['fields']['judul'],
            penulis: data['fields']['penulis'],
            tanggal_publikasi: data['fields']['tanggal_publikasi'],
            konten: data['fields']['konten']);

        AllForum forum =
            AllForum(fields: fields, model: data['model'], pk: data['pk']);
        extractedForumData.add(forum);
      }

      return extractedForumData;
    } catch (error) {
      print(error);
    }
  }

  fetchDataVaksinasi() async {
    const url = 'https://vaksincovid19-api.vercel.app/api/vaksin';
    try {
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      Map<String, dynamic> responseJson = jsonDecode(json);
      totalsasaran = responseJson['totalsasaran']['value'];
      sasaransdmk = responseJson['sasaranvaksinsdmk']['value'];
      sasaranlansia = responseJson['sasaranvaksinlansia']['value'];
      sasaranpetugas = responseJson['sasaranvaksinpetugaspublik']['value'];
      dosis1 = responseJson['vaksinasi1']['value'];
      dosis2 = responseJson['vaksinasi2']['value'];
      lastUpdate = responseJson['lastUpdate']['value'];
      return;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    request.username != "" ? isUser = true : isUser = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Vaksin'),
      ),
      drawer: isUser ? MainDrawerLogin() : MainDrawer(),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeVaksinContainer(isUser: isUser),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Data Vaksinasi COVID-19 di Indonesia',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Color.fromRGBO(89, 165, 216, 1)),
                ),
                Text(
                  ' ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'TOTAL SASARAN',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          totalsasaran.toString(),
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  ' ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ),
                Text(
                  'Sasaran Vaksin',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromRGBO(89, 165, 216, 1)),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'SDMK',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          sasaransdmk.toString(),
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'LANJUT USIA',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          sasaranlansia,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'PETUGAS PUBLIK',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          sasaranpetugas,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'VAKSINASI DOSIS 1',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          dosis1,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Card(
                    color: Color.fromRGBO(89, 165, 216, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          title: Text(
                            'VAKSINASI DOSIS 2',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                        ),
                        Text(
                          dosis2,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  ' ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                ),
                Text(
                  'Terakhir diperbarui :',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(89, 165, 216, 1)),
                ),
                Text(
                  lastUpdate,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(89, 165, 216, 1)),
                ),
                Text(
                  ' ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
