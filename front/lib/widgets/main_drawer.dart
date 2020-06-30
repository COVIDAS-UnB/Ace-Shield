import 'package:flutter/material.dart';
import 'package:front/screens/bottom_tab_screen.dart';
import 'package:provider/provider.dart';

import '../screens/leaving_time_screen.dart';
import '../screens/time_optmizer_screen.dart';
import '../screens/report_covid_screen.dart';
import '../providers/auth.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Menu',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Início',
            Icons.home,
            () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile(
            'Estou com COVID',
            Icons.brightness_7,
            () {
              // Navigator.of(context).pushNamed(ReportCovidScreen.routeName);
              Navigator.of(context)
                  .pushReplacementNamed(ReportCovidScreen.routeName);
            },
          ),
          buildListTile(
              'Salas frequentadas por infectados', Icons.report_problem, () {}),
          buildListTile('Verifique sua oferta', Icons.calendar_today, () {
            Navigator.of(context).pushReplacementNamed(BottomTabScreen.routeName);
          }),
          buildListTile('Horário de saída da semana', Icons.access_time, () {
            Navigator.of(context)
                  .pushReplacementNamed(LeavingTimeScreen.routeName);
          }),
          buildListTile(
            'Sair',
            Icons.power_settings_new,
            () {
              Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
