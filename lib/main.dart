import 'package:donasi/screens/donasi_add_form.dart';
import 'package:donasi/screens/donasi_home.dart';
import 'package:flutter/material.dart';
import 'package:kritik_saran/screens/kritik_saran_home.dart';
import 'package:update_covid/UCProv.dart';
import 'package:update_covid/harapan_uc.dart';
import 'package:update_covid/update_covid.dart';
import 'cookies.dart';
import 'package:home/screens/after_login.dart';
import 'screens/login_screen.dart';
import 'package:home/screens/tabs_screen.dart';
import 'screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:kontak/screens/home_kontak.dart';
import 'package:kontak/screens/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();

          return request;
        },
        child: MaterialApp(
          title: 'Rumah Harapan🏠',
          theme: ThemeData(
            // ini kayak css
            primarySwatch: Colors.blue,
          ),
          home: const TabsScreen(),
          routes: {
            TabsScreen.routeName: (ctx) => const TabsScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            AfterLogin.routeName: (ctx) => AfterLogin(),
            DonasiHome.routeName: (ctx) => DonasiHome(),
            AddDonasiForm.routeName: (ctx) => AddDonasiForm(),
            ContactHome.routeName: (ctx) => ContactHome(),
            AddKontakForm.routeName: (ctx) => AddKontakForm(),
            UpdateCovid.routeName: (ctx) => UpdateCovid(indexPage: 0),
            UCProv.routeName: (ctx) => UpdateCovid(indexPage: 1),
            HarapanUC.routeName: (ctx) => UpdateCovid(indexPage: 2),
            KritikSaranHome.routeName: (ctx) => KritikSaranHome()
          },
        ));
  }
}
