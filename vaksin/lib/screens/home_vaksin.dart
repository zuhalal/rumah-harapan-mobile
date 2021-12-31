import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/widgets/main_drawer.dart';
import 'package:rumah_harapan/widgets/main_drawer_login.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/widgets/forum_informasi_vaksin.dart';
import 'package:vaksin/widgets/home_vaksin_container.dart';

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
  int sasaranlansia = 0;
  int sasaranpetugas = 0;
  int dosis1 = 0;
  int dosis2 = 0;

  fetchDataKonten() async {
    const url = 'http://rumah-harapan.herokuapp.com/vaksin/all-forum';
    print("masuk");
    try {
      extractedForumData = [];
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);

      for (var data in jsonData) {
        Fields fields = Fields(
            judul: data['fields']['judul'],
            penulis: data['fields']['penulis'],
            tanggalPublikasi: data['fields']['tanggal_publikasi'],
            konten: data['fields']['konten']);

        AllForum forum = AllForum(fields: fields, model: data['model'], pk: data['pk']);
        extractedForumData.add(forum);
      }
      return extractedForumData;
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchData() async {
    const url = 'https://vaksincovid19-api.vercel.app/api/vaksin';
    try {
      final response = await http.get(Uri.parse(url));
      final json = response.body;
      Map<String, dynamic> responseJson = jsonDecode(json);
      totalsasaran = responseJson['totalsasaran'];
      sasaransdmk = responseJson['sasaranvaksinsdmk'];
      sasaranlansia = responseJson['sasaranvaksinlansia'];
      sasaranpetugas = responseJson['sasaranvaksinpetugaspublik'];
      dosis1 = responseJson['vaksinasi1'];
      dosis2 = responseJson['vaksinasi2'];
      return;
    } catch (error) {
      print(error);
    }
  }

  void didChangeDependencies() {
    fetchData();
    super.didChangeDependencies();
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
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      // Here you told Flutter to use the word "snapshot".
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: CircularProgressIndicator());
                      else
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      sasaranlansia.toString(),
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
                                      sasaranpetugas.toString(),
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
                                      dosis1.toString(),
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
                                      dosis2.toString(),
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
                          ],
                        );
                    },
                  ),
                ),
                Container(
                  color: Color.fromRGBO(173, 232, 244, 1),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          ' ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Color.fromRGBO(173, 232, 244, 1)),
                        ),
                        Text(
                          'Forum Informasi',
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
                              fontSize: 22,
                              color: Color.fromRGBO(173, 232, 244, 1)),
                        ),
                        SingleChildScrollView(
                          child: FutureBuilder(
                        future: fetchDataKonten(),
                        builder: (context, snapshot) {
                      // Here you told Flutter to use the word "snapshot".
                          if (snapshot.connectionState == ConnectionState.waiting)
                            return Center(child: CircularProgressIndicator());
                          else
                            return  Column(
                                children: extractedForumData
                                    .map((list) => ForumInformasiContainer(
                                  forum: list,
                                ))
                                    .toList(),
                              );
                            }
                          )
                        )
                      ],
                    )),
                  ),
                )
              ])),
        ));
  }
}
