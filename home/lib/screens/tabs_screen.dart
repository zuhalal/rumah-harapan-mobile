import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rumah_harapan/widgets/main_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs_screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rumah Harapan'),
        backgroundColor: Color.fromRGBO(89, 165, 216, 1),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Container(
          color: Color.fromRGBO(173, 232, 244, 1),
          width: double.infinity,
          padding: EdgeInsets.only(top: 160, left: 12, right: 12, bottom: 100),
          child: Column(
            children: <Widget>[
              const Text(
                'Rumah Harapan',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              const Text(
                'Aplikasi ini berisikan segala informasi mengenai COVID-19, mulai dari angka penyebaran, angka kematian, sembuh, dan kasus aktif, informasi vaksin, dan sebagainya.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/home/home.png',
                  height: 300,
                  width: 300,
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(top: 160, left: 12, right: 12, bottom: 100),
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: const Text(
                    'Keuntungan Menjadi',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(89, 165, 216, 1),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: const Text(
                    '#TemanHarapan',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(89, 165, 216, 1),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/home/article.jpg',
                  height: 300,
                  width: 300,
                ),
              ),
              const Text(
                'Membaca artikel',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/home/call.jpg',
                  height: 300,
                  width: 300,
                ),
              ),
              const Text(
                'Telpon nomor yang dibutuhkan',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/home/write.png',
                  height: 300,
                  width: 300,
                ),
              ),
              const Text(
                'Menulis artikel',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(89, 165, 216, 1),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Color.fromRGBO(173, 232, 244, 1),
          width: double.infinity,
          padding: EdgeInsets.only(top: 160, left: 12, right: 12, bottom: 100),
          child: Column(
            children: <Widget>[
              Container(
                child: Center(
                  child: const Text(
                    'Gabung Menjadi',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(89, 165, 216, 1),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: const Text(
                    '#TemanHarapan',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(89, 165, 216, 1),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_screen');
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_screen');
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/home/friend.png',
                  height: 300,
                  width: 300,
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
