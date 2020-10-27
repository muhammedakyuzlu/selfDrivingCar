import 'package:SDC/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    // key for endDrawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
      }

  @override
  Widget build(BuildContext context) {
    

    return Consumer<Auth>(
      builder: (ctx, auth,child) => Scaffold(
        key: _scaffoldKey,
        body: Center(child: Text('Center'),)
      ),
    );
  }
}
