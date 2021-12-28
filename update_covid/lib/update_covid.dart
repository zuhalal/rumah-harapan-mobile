library update_covid;

import 'package:flutter/material.dart';
import 'package:rumah_harapan/widgets/main_drawer_login.dart';
import 'home_uc.dart';
import 'UCProv.dart';
import 'harapan_uc.dart';

class UpdateCovid extends StatefulWidget {
  static const routeName = '/updateCovid';
  const UpdateCovid({Key? key}) : super(key: key);
  @override
  _UpdateCovidState createState() => _UpdateCovidState();
}

class _UpdateCovidState extends State<UpdateCovid> {
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  // List<Harapan> get listHarapan => null;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeUC(),
      },
      {
        'page': UCProv(),
      },
      {
        'page': HarapanUC(), 
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rumah Harapan🏠'),
          backgroundColor: const Color.fromRGBO(89, 165, 216, 1),
        ),
        drawer: MainDrawerLogin(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Color.fromRGBO(89, 165, 216, 1),
          unselectedItemColor: Color.fromRGBO(2, 62, 128, 1),
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.query_stats),
              label: 'Harian Covid',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Data Provinsi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Kotak Harapan',
            ),
          ],
        ),
    );
  }
}

