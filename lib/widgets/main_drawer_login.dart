import 'package:flutter/material.dart';
import 'package:rumah_harapan/cookies.dart';
import 'package:provider/provider.dart';
import 'package:rumah_harapan/screens/login_screen.dart';

class MainDrawerLogin extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, void Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Color.fromRGBO(89, 165, 216, 1),
            child: Text(
              "Rumah Harapan 🏠",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.pushNamed(context, '/after_login');
          }),
          buildListTile('Donasi', Icons.volunteer_activism, () {
            Navigator.pushNamed(context, '/donasi');
          }),
          buildListTile('Artikel', Icons.announcement, () {
            Navigator.pop(context);
          }),
          buildListTile('Vaksin', Icons.announcement, () {
            Navigator.pushNamed(context, '/vaksin');
          }),
          buildListTile('Update Covid', Icons.update, () {
            Navigator.pushNamed(context, '/updateCovid');
          }),
          buildListTile('Kotak Penting', Icons.contacts, () {
            Navigator.pop(context);
          }),
          buildListTile('Logout', Icons.logout, () async {
            final response = await request
                .logoutAccount("http://rumah-harapan.herokuapp.com/logout2");
            if (response['status']) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Successfully logged out!"),
              ));
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("An error occured, please try again."),
              ));
            }
          }),
        ],
      ),
    );
  }
}
