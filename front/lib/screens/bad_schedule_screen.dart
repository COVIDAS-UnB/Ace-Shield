import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import '../models/class.dart';
import '../main.dart';

class BadScheduleScreen extends StatefulWidget {
  static const routeName = '/bad-schedule';

  @override
  _BadScheduleScreenState createState() => _BadScheduleScreenState();
}

class _BadScheduleScreenState extends State<BadScheduleScreen> {
  //Lista 0 = otimizada
  //Lista 1,2,3 = ruins
  static List<Class> _bestSchedule = relevantSchedules[3];
  static int _subjectsAmount = _bestSchedule.length;
  static List<List<bool>> _timeTable =
      generateTimeTable(_bestSchedule[0].schedule);
  static String _classIdentifier = _bestSchedule[0].getClassIdentifier();
  static String _classSubject = _bestSchedule[0].getSubject();
  static Class _dummyClass = new Class(null, '', '', null);
  static int _horas = getNumOfHoursAtUniversity(_bestSchedule);
  static int _dias = getNumDaysAtUniversity(_bestSchedule);

  int _matrixVerticalIndex = 0;
  int _matrixHorizontalIndex = 0;
  List<List> _stubSubject = [
    [1, 0, 1, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
  ];

  Class _getClass(int matrixVerticalIndex, int matrixHorizontalIndex) {
    for (var i = 0; i < _subjectsAmount; i++) {
      List<List<bool>> timeTable = generateTimeTable(_bestSchedule[i].schedule);
      if (timeTable[matrixHorizontalIndex][matrixVerticalIndex]) {
        return _bestSchedule[i];
      }
    }
    return _dummyClass;
  }

  Widget headerCard(String headerName) {
    return Card(
      elevation: 10.0,
      child: Container(
        child: Align(
            alignment: Alignment.center,
            child: Text(
              headerName,
              style: TextStyle(
                fontSize: 22,
              ),
            )),
      ),
    );
  }

  Widget subjectCard(Class cls) {
    return Card(
      elevation: 10.0,
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                cls.getSubject(),
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                cls.getClassIdentifier() == ''
                    ? ''
                    : 'Turma: ' + cls.getClassIdentifier(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          childAspectRatio: 1.2 / 3,
          crossAxisCount: 9,
          children: List.generate(
            54,
            (index) {
              if (index == 0) {
                return Card(
                  // color: Colors.green,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Total: ' + _horas.toString() + ' horas',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Número de dias: ' + _dias.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (index == 1) {
                return headerCard('8:00 - 10:00');
              } else if (index == 2) {
                return headerCard('10:00 - 12:00');
              } else if (index == 3) {
                return headerCard('12:00 - 14:00');
              } else if (index == 4) {
                return headerCard('14:00 - 16:00');
              } else if (index == 5) {
                return headerCard('16:00 - 18:00');
              } else if (index == 6) {
                return headerCard('18:00 - 19:00');
              } else if (index == 7) {
                return headerCard('19:00 - 21:00');
              } else if (index == 8) {
                return headerCard('21:00 - 22:30');
              } else if (index == 9) {
                return headerCard('Segunda');
              } else if (index == 18) {
                return headerCard('Terça');
              } else if (index == 27) {
                return headerCard('Quarta');
              } else if (index == 36) {
                return headerCard('Quinta');
              } else if (index == 45) {
                return headerCard('Sexta');
              }
              if (_matrixVerticalIndex > 7) {
                _matrixVerticalIndex = 0;
                _matrixHorizontalIndex++;
              }
              if (_matrixHorizontalIndex > 4) {
                _matrixHorizontalIndex = 0;
              }
              return subjectCard(
                  _getClass(_matrixVerticalIndex++, _matrixHorizontalIndex));
            },
          ),
        ),
      ),
    );
  }
}
