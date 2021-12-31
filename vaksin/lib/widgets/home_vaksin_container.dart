import 'package:flutter/material.dart';
import 'package:rumah_harapan/screens/login_screen.dart';
import 'package:vaksin/screens/add_forum_vaksin.dart';

class HomeVaksinContainer extends StatefulWidget {
  const HomeVaksinContainer({Key? key, required this.isUser}) : super(key: key);
  final bool isUser;

  @override
  _HomeVaksinContainer createState() => _HomeVaksinContainer();
}

class _HomeVaksinContainer extends State<HomeVaksinContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
          color: const Color(0xffade8f4),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset('assets/images/vaksin/get_vaccine.png'),
                Text('Informasi Vaksin',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: const Color(0xff59A5D8))),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: Text(
                      'Mari saling berbagi informasi antar sesama #TemanHarapan di tengah pandemi COVID-19.'
                      'Pada halaman ini, Anda dapat mengakses informasi perkembangan vaksinasi COVID-19 di Indonesia.'
                      'Anda juga dapat berkontribusi memberikan informasi terkait jenis vaksin COVID-19, Kejadian Ikutan Pasca Imunisasi (KIPI),dan informasi mengenai vaksin COVID-19 lainnya dalam forum informasi pada halaman ini.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                ),
                SizedBox(height: 24),
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
