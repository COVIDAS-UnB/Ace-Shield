import 'package:flutter/material.dart';
import 'package:front/dummy_data.dart';
import './screens/report_covid_screen.dart';
import './widgets/main_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ace Shield',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        // '/': (ctx) => HomeScreen(),
        // CalendarScreen.routeName: (ctx) => CalendarScreen(),
        ReportCovidScreen.routeName: (ctx) => ReportCovidScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ace Shield'),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: DUMMY_CLASSES.map((cls) {
              return Card(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  color: cls.infectedPeople > 0 ? Colors.red[300] : Colors.green[400],
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          cls.subject,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Text(
                        'Turma: ' + cls.classIdentifier,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Número de infectados: ' +
                            cls.infectedPeople.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
