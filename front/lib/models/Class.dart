import 'package:flutter/material.dart';
import 'dart:math';

class Class {
  final List<List<int>> schedule;
  final String subject;
  final String classIdentifier;
  final int numOfCreds;
  final int infectedPeople;

  const Class({
    @required this.schedule,
    @required this.subject,
    @required this.classIdentifier,
    @required this.numOfCreds,
    @required this.infectedPeople,
  });
}

Set<String> subjectNames = {
  "cálculo1",
  "introduçãoàeconomia",
  "introduçãoàsociologia",
  "introduçãoàciênciapolítica",
  "física1",
  "introduçãoàadministração",
  "matemática1",
  "introduçãoàalgebralinear",
  "introduçãoàfilosofia",
  "químicageralexperimental",
  "física1experimental",
  "cálculo2",
  "estatísticaaplicada",
  "línguasinaisbras-básico",
  "organizaçãoeducbrasileira",
  "introduçãoàantropologia",
  "psicologiadaeducação",
  "químicageralteórica",
  "cálculo3",
  "instdedirpúblicoeprivado",
  "probabilidadeeestatística",
  "práticadesportiva",
  "introduçãoàpsicologia",
  "didáticafundamental",
  "introduçãoàlinguística",
  "introdaoestudodahistória",
  "introduçãoaodireito1",
  "introduçãoàatividadeempresarial",
  "física2",
  "introduçãoàteoriadaliteratura",
  "algoritmosprogrcomputadores",
  "inglêsinstrumental1",
  "ciênciasdoambiente",
  "introduçãoàciênciadacomputação",
  "promoçãodasaúde3",
  "formaçãoeconômicadobrasil",
  "psicologiadapersonalidade1",
  "citologia",
  "desenvolvimentopsicológicoeensino",
  "itroduçãoàcontabilidade",
  "elementosdeanatomia",
  "bioquímicafundamental",
  "biologiaestruturaldostecidos",
  "práticadetextos",
  "cantocoral1",
  "contabilidadegeral1",
  "calculonumerico",
  "organologiasistemáticafanerofítica",
  "leituraeproduçãodetextos",
  "portuguêsinstrumental1"
};

List<Class> generateOffer() {
  List<Class> offer = List<Class>();
  var rng = new Random(95);
  for (var subjectName in subjectNames) {
    int numOfHoraries = (1 + rng.nextInt(3));
    int numOfCreds = 2 * numOfHoraries;
    int numOfUniqueClasses = 1 + rng.nextInt(26);
    for (int i = 1; i <= numOfUniqueClasses; i++) {
      List<List<int>> schedule = new List<List<int>>();
      List<int> daysAlreadyUsed = new List<int>();
      for (int i = 0; i < numOfHoraries; i++) {
        int weekDay = rng.nextInt(5);
        while (daysAlreadyUsed.contains(weekDay)) {
          weekDay = rng.nextInt(5);
        }
        daysAlreadyUsed.add(weekDay);
        int period = rng.nextInt(6);
        List<int> timePair = new List<int>(2);
        timePair[0] = weekDay;
        timePair[1] = period;
        schedule.add(timePair);
      }
      schedule.sort((a, b) => (a[0] > b[0]) ? 1 : -1);
      Class aClass = new Class(
          schedule: schedule,subject: subjectName, classIdentifier: String.fromCharCode(64 + i), numOfCreds: numOfCreds, infectedPeople: 0);
      offer.add(aClass);
    }
  }
  return offer;
}

void printClass(Class theClass) {
  print(theClass.subject);
  var classIdentifier = theClass.classIdentifier;
  print("TURMA $classIdentifier");
  for (var horary in theClass.schedule) {
    var day = numToDay(horary[0]);
    var time = numToTime(horary[1]);
    print(" $day $time");
  }
}

String numToDay(int i) {
  switch (i) {
    case 0:
      {
        return "SEG";
      }
      break;

    case 1:
      {
        return "TER";
      }
      break;

    case 2:
      {
        return "QUA";
      }
      break;

    case 3:
      {
        return "QUI";
      }
      break;

    default:
      {
        return "SEX";
      }
      break;
  }
}

String numToTime(int i) {
  switch (i) {
    case 0:
      {
        return "8-10";
      }
      break;

    case 1:
      {
        return "10-12";
      }
      break;

    case 2:
      {
        return "14-16";
      }
      break;

    case 3:
      {
        return "16-18";
      }
      break;

    case 4:
      {
        return "19-21";
      }
      break;

    default:
      {
        return "21-22:30";
      }
      break;
  }
}
