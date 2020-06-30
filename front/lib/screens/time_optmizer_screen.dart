import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class TimeOptimizerScreen extends StatefulWidget {
  static const routeName = '/time-optimizer';

  @override
  _TimeOptimizerScreenState createState() => _TimeOptimizerScreenState();
}

class _TimeOptimizerScreenState extends State<TimeOptimizerScreen> {
  int _matrixIndex = 0;
  List<List> _stubSubject = [
    [
      0,0,0,0,0,
      1,0,1,0,1,
      0,0,0,0,0,
      0,0,0,0,0,
      0,0,0,0,0,
      0,0,0,0,0,
      0,0,0,0,0,
      0,0,0,0,0,
    ],
  ];

  Widget subjectCard(String num) {
    return Card(
      elevation: 10.0,
      child: new Container(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              num,
              style: TextStyle(
                fontSize: 25,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Monte sua grade horária'),
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
        body: GridView.count(
          scrollDirection: Axis.horizontal,
          childAspectRatio: 1.4 / 3,
          crossAxisCount: 9,
          children: List.generate(
            54,
            (index) {
              if (index == 0) {
                return Card();
              } else if (index == 1) {
                return subjectCard('8:00-10:00');
              } else if (index == 2) {
                return subjectCard('10:00-12:00');
              } else if (index == 3) {
                return subjectCard('12:00-14:00');
              } else if (index == 4) {
                return subjectCard('14:00-16:00');
              } else if (index == 5) {
                return subjectCard('16:00-18:00');
              } else if (index == 6) {
                return subjectCard('18:00-19:00');
              } else if (index == 7) {
                return subjectCard('19:00-21:00');
              } else if (index == 8) {
                return subjectCard('21:00-22:30');
              } else if (index == 9) {
                return subjectCard('Segunda');
              } else if (index == 18) {
                return subjectCard('Terça');
              } else if (index == 27) {
                return subjectCard('Quarta');
              } else if (index == 36) {
                return subjectCard('Quinta');
              } else if (index == 45) {
                return subjectCard('Sexta');
              }
              return subjectCard(index.toString());
            },
          ),
        )
        // GridView(
        //   children: <Widget>[
        //     Text('Seg'),
        //     Text('Ter'),
        //     Text('Qua'),
        //     Text('Qui'),
        //     Text('Sex'),
        //     Text('Sáb'),
        //   ],
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 60,
        //     childAspectRatio: 3 / 2,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20,
        //   ),
        // ),
        );
  }
}
