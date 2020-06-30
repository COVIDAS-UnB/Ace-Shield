import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import '../widgets/main_drawer.dart';

class LeavingTimeScreen extends StatelessWidget {
  static const routeName = '/leaving-time';

  Widget weekDayText(String day) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text(
        day,
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horário de Saída das Aulas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              // implementar
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: VerticalTabs(
        tabsWidth: 150,
        tabs: <Tab>[
          Tab(
            child: weekDayText('Seg'),
          ),
          Tab(
            child: weekDayText('Ter'),
          ),
          Tab(
            child: weekDayText('Qua'),
          ),
          Tab(
            child: weekDayText('Qui'),
          ),
          Tab(
            child: weekDayText('Sex'),
          ),
        ],
        contents: <Widget>[
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(color: Colors.grey),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text('Matéria: '),
                    Text('Sala: '),
                    Text('Horário de Saída: '),
                  ],
                ),
              ),
            ],
          ),
          Container(child: Text('Terça'), padding: EdgeInsets.all(20)),
          Container(child: Text('Quarta'), padding: EdgeInsets.all(20)),
          Container(child: Text('Quinta'), padding: EdgeInsets.all(20)),
          Container(child: Text('Sexta'), padding: EdgeInsets.all(20))
        ],
      ),
    );
  }
}
