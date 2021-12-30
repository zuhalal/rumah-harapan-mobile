import 'package:donasi/screens/donasi_add_form.dart';
import 'package:flutter/material.dart';
import 'package:rumah_harapan/screens/login_screen.dart';

class DonasiContainer extends StatefulWidget {
  const DonasiContainer({Key? key, required this.isUser}) : super(key: key);
  final bool isUser;

  @override
  _DonasiContainerState createState() => _DonasiContainerState();
}

class _DonasiContainerState extends State<DonasiContainer> {
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
                Image.asset('assets/images/donasi/3724843.png'),
                Text("Donasi",
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
                      "Mari kita ringankan beban sesama #TemanHarapan di tengah pandemi Covid-19 ini. Kamu dapat membantu dengan berdonasi sesuai dengan keinginan dan keikhlasan kamu. "
                      "Setiap uang yang kamu keluarkan dapat menjadi pintu rezeki bagi mereka yang membutuhkan. ",
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
                                side: BorderSide(width: 2, color: const Color(0xff023E8A)),
                                padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0))),
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (context) => AddDonasiForm());
                              Navigator.push(context, route);
                            },
                            child: const Text('Buat Donasi'),
                          ),
                        ]
                      : [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              primary: const Color(0xff023E8A),
                              side: BorderSide(width: 2, color: const Color(0xff023E8A)),
                              onPrimary: Colors.white,
                              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
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
                                        'Silakan Login Untuk Menambahkan Donasi',
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
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                8.0))),
                                            onPressed: () =>  Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                                            child: Text("Login")),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(fontSize: 20),
                                            primary: Colors.black12,
                                            onPrimary: Colors.white,
                                            side: BorderSide(width: 2, color: const Color(0xff023E8A)),
                                            padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('Batal'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text('Buat Donasi'),
                          ),
                        ],
                ),
              ],
            ),
          )),
    );
  }
}
