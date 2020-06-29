import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class ReportCovidScreen extends StatelessWidget {
  static const routeName = '/report-covid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estou com COVID'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              //
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text(
          'Report Covid Screen',
        ),
      ),
    );
  }
}
