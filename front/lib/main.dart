import 'package:flutter/material.dart';
import 'package:front/screens/bottom_tab_screen.dart';
import 'package:provider/provider.dart';

import './screens/leaving_time_screen.dart';
import './screens/time_optmizer_screen.dart';
import './screens/splash_screen.dart';
import './dummy_data.dart';
import './providers/auth.dart';
import './screens/report_covid_screen.dart';
import './widgets/main_drawer.dart';
import './screens/auth_screen.dart';
import './models/class.dart';

List<List<Class>> relevantSchedules;

void main() {
  classMain();
  relevantSchedules = refresh(5);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Ace Shield',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          // home: MyHomePage(),
          // initialRoute: '/',
          home: auth.isAuth
              ? MyHomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            // '/': (ctx) => HomeScreen(),
            // CalendarScreen.routeName: (ctx) => CalendarScreen(),
            ReportCovidScreen.routeName: (ctx) => ReportCovidScreen(),
            LeavingTimeScreen.routeName: (ctx) => LeavingTimeScreen(),
            TimeOptimizerScreen.routeName: (ctx) => TimeOptimizerScreen(),
            BottomTabScreen.routeName: (ctx) => BottomTabScreen(),
          },
        ),
      ),
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
        title: Text('Minhas Turmas'),
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
                elevation: 15,
                margin: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 15,
                    bottom: 15,
                    top: 15,
                  ),
                  color: Colors.transparent,
                  // color: cls.infectedPeople > 0
                  //     ? Colors.red[300]
                  //     : Colors.green[400],
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: double.infinity,
                        child: Text(
                          cls.subject,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: double.infinity,
                        child: Text(
                          'Turma: ' + cls.classIdentifier,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              'Número de infectados: ' +
                                  cls.infectedPeople.toString() + '             ',
                              style: TextStyle(fontSize: 20),
                            ),
                            cls.infectedPeople > 0
                                ? Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                          ],
                        ),
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
