import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:rumah_harapan/screens/login_screen.dart';
import 'package:vaksin/models/konten_vaksin.dart';
import 'package:vaksin/screens/add_forum_vaksin.dart';

class ForumInformasiContainer extends StatefulWidget {
  const ForumInformasiContainer(
      {Key? key,
      required this.konten,
      required this.userPk,
      required this.userName,
      required this.isUser})
      : super(key: key);
  final AllForum konten;
  final Map<String, int> userPk;
  final Map<int, String> userName;
  final bool isUser;

  @override
  _ForumInformasiContainer createState() => _ForumInformasiContainer();
}

class _ForumInformasiContainer extends State<ForumInformasiContainer> {
  String judul = '';
  String penulis = '';
  DateTime tanggalPublikasi = '' as DateTime;
  String konten = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    judul = widget.konten.fields.judul;
    penulis = widget.konten.fields.penulis;
    tanggalPublikasi = widget.konten.fields.tanggal_publikasi as DateTime;
    konten = widget.konten.fields.konten;

    return SizedBox(
      width: double.infinity,
      child: Container(
          color: const Color(0xffade8f4),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 50,
                  color: Color.fromRGBO(89, 165, 216, 1),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person_pin,
                                  size: 32,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      judul,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Penulis: ' + penulis,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                    Text(
                                      "Tanggal Publikasi: " +
                                          DateFormat('kk:mm - dd-MM-yyyy')
                                              .format(tanggalPublikasi),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            konten,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.isUser
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
          )),
    );
  }
}
