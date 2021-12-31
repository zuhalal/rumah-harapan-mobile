import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/screens/login_screen.dart';
import 'package:rumah_harapan/widgets/main_drawer.dart';
import 'package:rumah_harapan/widgets/main_drawer_login.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/screens/add_forum_vaksin.dart';
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
  String totalsasaran = '';
  String sasaransdmk = '';
  String sasaranlansia = '';
  String sasaranpetugas = '';
  String dosis1 = '';
  String dosis2 = '';
  String lastUpdate = '';

  fetchDataKonten() async {
    const url = 'http://rumah-harapan.herokuapp.com/vaksin/all-forum';

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
      Map<String, dynamic> json = jsonDecode(response.body);
      totalsasaran = json['totalsasaran'];
      sasaransdmk = json['sasaranvaksinsdmk'];
      sasaranlansia = json['sasaranvaksinlansia'];
      sasaranpetugas = json['sasaranvaksinpetugaspublik'];
      dosis1 = json['vaksinasi1'];
      dosis2 = json['vaksinasi2'];
      lastUpdate = json['lastUpdate'];
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
                ),
                for (AllForum i in extractedForumData)
                  ForumInformasiContainer(konten: i, isUser: isUser),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: isUser
                      ? [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                                onPrimary: Colors.white,
                                primary: const Color(0xff023E8A),
                                side: BorderSide(
                                    width: 2, color: const Color(0xff023E8A)),
                                padding: EdgeInsets.only(
                                    left: 12, right: 12, top: 8, bottom: 8),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0))),
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => AddForumVaksin());
                              Navigator.push(context, route);
                            },
                            child: const Text('Tambah Informasi'),
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
                                  borderRadius: new BorderRadius.circular(8.0)),
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
                                        'Silakan Login untuk Menambahkan Informasi',
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
                                                    top: 10,
                                                    bottom: 10),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                8.0))),
                                            onPressed: () =>
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    LoginScreen.routeName),
                                            child: Text('Login')),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle:
                                                const TextStyle(fontSize: 20),
                                            primary: Colors.black12,
                                            onPrimary: Colors.white,
                                            side: BorderSide(
                                                width: 2,
                                                color: const Color(0xff023E8A)),
                                            padding: EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 10,
                                                bottom: 10),
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0)),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Batal'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Tambah Informasi'),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
