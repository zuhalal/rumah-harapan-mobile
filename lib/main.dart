import 'package:donasi/screens/donasi_add_form.dart';
import 'package:donasi/screens/donasi_home.dart';
import 'package:flutter/material.dart';
import 'cookies.dart';
import 'package:home/screens/after_login.dart';
import 'screens/login_screen.dart';
import 'package:home/screens/tabs_screen.dart';
import 'screens/register_screen.dart';
import 'package:provider/provider.dart';

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
            AddDonasiForm.routeName: (ctx) => AddDonasiForm()
          },
        ));
  }
}
