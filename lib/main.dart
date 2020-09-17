import 'package:flutter/material.dart';
//import 'package:newApp/screens/login.dart';
import 'package:library_app/screens/login.dart';


void main() {
  runApp(MaterialApp(
    home: Dashboard(),
    debugShowCheckedModeBanner: false,
  ));
}


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}