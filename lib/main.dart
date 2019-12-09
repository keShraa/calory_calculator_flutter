import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

MaterialColor color = Colors.pink;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcory',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Calculez votre besoin journalier'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool homme = false;
  DateTime date;
  int yourAge;
  double tailleDouble = 130.0;
  String submitted;
  int itemSelectionne;
  List<String> activities = ["Faible", "Modéré", "Forte"];


  List<Widget> radios() {
    List<Widget> l = [];
    for (int x = 0; x < 3; x++) {
      Row row = new Row(
        children: <Widget>[
          Text(activities[x]),
          new Radio(value: x,
              groupValue: itemSelectionne,
              activeColor: color,
              onChanged: (int i) {
                setState(() {
                  itemSelectionne = i;
                });
              }),
        ],
      );
      l.add(row);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7.0),
              child: Text(
                'Remplissez tous les champs pour obtenir votre besoin journalier en calories.',
                textAlign: TextAlign.center,
              ),
            ),
            Card(
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Femme',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: (homme) ? Colors.black : color),
                        ),
                        Switch(
                          value: homme,
                          activeColor: Colors.blue,
                          inactiveTrackColor: Colors.pink,
                          inactiveThumbColor: Colors.pink,
                          onChanged: (bool b) {
                            setState(() {
                              homme = b;
                              (homme)
                                  ? color = Colors.blue
                                  : color = Colors.pink;
                            });
                          },
                        ),
                        Text(
                          'Homme',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: (homme) ? color : Colors.black),
                        ),
                      ],
                    ),
                    RaisedButton(
                      color: color,
                      child: Text(
                        (date == null) ? "Date de naissance" : "Votre âge est de ${yourAge} ans",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: birthDate,
                    ),
                    Text(
                      "Votre taille est de ${tailleDouble.floor()}cm.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color),
                    ),
                    Slider(
                      value: tailleDouble,
                      min: 130.0,
                      max: 210.0,
                      activeColor: color,
                      onChanged: (double d) {
                        setState(() {
                          tailleDouble = d;
                        });
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (String string) {
                        setState(() {
                          submitted = 'Votre poids est de ${string}kg.';
                        });
                      },
                      decoration: InputDecoration(
                          labelText:'Entrez votre poids en kilos.'
                      ),
                    ),
                    Text(
                        submitted ?? '',
                      style: TextStyle(color: color),
                    ),
                    Text(
                      'Quelle est votre activité sportive ?'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: radios(),
                    ),
                  ],
                ),
              ),
            ),
            RaisedButton(
              color: color,
              child: Text('Calculer votre besoin',
                  textScaleFactor: 1.2, style: TextStyle(color: Colors.white)),
              onPressed: calculate,
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> birthDate() async {
    DateTime choice = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1930),
        lastDate: DateTime.now());
    if (choice != null) {
      setState(() {
        date = choice;
        yourAge = (DateTime.now().difference(date).inDays / 365.25).floor();
      });
    }
  }

  Future<Null> calculate() async {}
}
