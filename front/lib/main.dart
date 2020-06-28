import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void redirectTo() {
    print('redirecionando...');
  }

  @override
  Widget build(BuildContext context) {
    var coreFeatures = [
      'Informe seu diagnóstico aqui',
      'Verifique quando sua aula irá terminar hoje',
      'Monte sua grade horária aqui',
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nome muito bacana'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text(coreFeatures[0]),
              onPressed: redirectTo,
            ),
            RaisedButton(
              child: Text(coreFeatures[1]),
              onPressed: redirectTo,
            ),
            RaisedButton(
              child: Text(coreFeatures[2]),
              onPressed: redirectTo,
            ),
          ],
        ),
      ),
    );
  }
}
