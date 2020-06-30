import 'dart:io';
import 'dart:math';
import 'dart:collection';
import 'package:trotter/trotter.dart';

var offer;
var offerBySubject;
var offerByDay;
var offerByPeriod;
var offerByHorary;

class Horary {
  int weekDay;
  int period;
  Horary(this.weekDay, this.period);
  String numToDay(int i) {
    switch(i) {
      case 0: {
        return "SEG" ;
      }
      break;

      case 1: {
        return "TER";
      }
      break;

      case 2: {
        return "QUA";
      }
      break;

      case 3: {
        return "QUI";
      }
      break;

      default: {
        return "SEX";
      }
      break;
    }
  }

  String numToTime(int i) {
    switch(i) {
      case 0: {
        return "8-10" ;
      }
      break;

      case 1: {
        return "10-12";
      }
      break;

      case 2: {
        return "14-16";
      }
      break;

      case 3: {
        return "16-18";
      }
      break;

      case 4: {
        return "19-21";
      }
      break;

      default: {
        return "21-22:30";
      }
      break;
    }
  }
  @override
  String toString() {
    var weekDayName = numToDay(weekDay);
    var periodRange = numToTime(period);
    return weekDayName + " " + periodRange;
  }
  @override
  bool operator==(dynamic other) {
    if(other is Horary) {
      if(this.weekDay == other.weekDay && this.period == other.period) {
        return true;
      }
    }
    return false;
  }
  @override
  int get hashCode => weekDay*31 + period;
}

class Class {
  Set<Horary> schedule;
  String subject;
  String classIdentifier;
  int numOfCreds;
  Class(this.schedule, this.subject, this.classIdentifier, this.numOfCreds);
  String getSubject() {
    return subject;
  }
  String getClassIdentifier() {
    return classIdentifier;
  }

}

class GradedStudentSchedule {
  List<Class> studentSchedule;
  double heuristicsGrade;
  GradedStudentSchedule(List<Class> studentSchedule) {
    this.studentSchedule = studentSchedule;
    heuristicsGrade = getHeuristic(studentSchedule);
  }
}

List<String> subjectNames = {"Cálculo 1", "Física 1", "Introdução à Álgebra Linear",
  "Introdução à Economia", "Introdução à Sociologia", "Introdução à Ciência Política", "Introdução à Administração",
  "Matemática 1", "Introdução à Álgebra Linear",  "Introdução à Filosofia", "Química Geral Experimental",
  "Física 1 Experimental", "Cálculo 2", "Estatística Aplicada", "Língua Sinais Bras-básico",
  "Organização Educ Brasileira", "Introdução à Antropologia", "Psicologia da Educação", "Química Geral Teórica",
  "Cálculo 3", "Inst de Dir Público e Privado", "Probabilidade e Estatística", "Prática Desportiva",
  "Introdução à Psicologia", "Didática Fundamental", "Introdução à Linguística", "Introd ao Estudo da História",
  "Introdução ao Direito 1", "Introdução à Atividade Empresarial", "Física 2", "Introdução à Teoria da Literatura",
  "Algoritmos Progr Computadores", "Inglês Instrumental 1", "Ciências do Ambiente",
  "Introdução à Ciência da Computação", "Promoção da Saúde 3", "Formação Econômica do Brasil",
  "Psicologia da Personalidade 1", "Citologia", "Desenvolvimento Psicológico e Ensino",
  "Introdução à Contabilidade", "Elementos de Anatomia", "Bioquímica Fundamental",
  "Biologia Estrutural dos Tecidos", "Prática de Textos", "Canto Coral 1", "Contabilidade Geral 1",
  "Cálculo Numérico", "Organologia Sistemática Fanerofítica", "Leitura e Produção de Textos",
  "Português Instrumental 1"}.toList();

List<Class> generateOffer() {
  List<Class> offer = List<Class>();
  var rng = new Random(0);
  for (var subjectName in subjectNames) {
    int numOfHoraries = (1 + rng.nextInt(3));
    int numOfCreds = 2 * numOfHoraries;
    int numOfUniqueClasses = 3 + rng.nextInt(4);
    for (int i = 1; i <= numOfUniqueClasses; i++) {
      Set<Horary> schedule = new Set<Horary>();
      List<int> daysAlreadyUsed = new List<int>();
      for (int i = 0; i < numOfHoraries; i++) {
        int weekDay = rng.nextInt(5);
        while(daysAlreadyUsed.contains(weekDay)) {
          weekDay = rng.nextInt(5);
        }
        daysAlreadyUsed.add(weekDay);
        int period = rng.nextInt(6);
        Horary horary = new Horary(weekDay, period);
        schedule.add(horary);
      }
      Class aClass = new Class(schedule, subjectName.toUpperCase(), String.fromCharCode(64 + i), numOfCreds);
      offer.add(aClass);
    }
  }
  return offer;
}

Map<String, List<Class>> getOfferBySubject(List<Class> offer) {
  Map<String, List<Class>> offerBySubject = new Map<String, List<Class>>();
  for(var subjectName in subjectNames) {
    offerBySubject[subjectName.toUpperCase()] = new List<Class>();
  }
  for(Class aClass in offer) {
    offerBySubject[aClass.subject].add(aClass);
  }
  return offerBySubject;
}

Map<int, List<Class>> getOfferByDay(List<Class> offer) {
  Map<int, List<Class>> offerByDay = new Map<int, List<Class>>();
  for(int i = 0; i < 5; i++) {
    offerByDay[i] = new List<Class>();
  }
  for(Class aClass in offer) {
    for(var horary in aClass.schedule) {
      offerByDay[horary.weekDay].add(aClass);
    }
  }
  return offerByDay;
}

Map<int, List<Class>> getOfferByPeriod(List<Class> offer) {
  Map<int, List<Class>> offerByDay = new Map<int, List<Class>>();
  for(int i = 0; i < 6; i++) {
    offerByDay[i] = new List<Class>();
  }
  for(Class aClass in offer) {
    for(var horary in aClass.schedule) {
      offerByDay[horary.period].add(aClass);
    }
  }
  return offerByDay;
}

Map<Horary, List<Class>> getOfferByHorary(List<Class> offer) {
  Map<Horary, List<Class>> offerByHorary = new Map<Horary, List<Class>>();
  for(int weekDay = 0; weekDay < 5; weekDay++) {
    for(int period = 0; period < 6; period++) {
      var horary = Horary(weekDay, period);
      offerByHorary[horary] = new List<Class>();
    }
  }
  for(Class aClass in offer) {
    for(var horary in aClass.schedule) {
      offerByHorary[horary].add(aClass);
    }
  }
  return offerByHorary;
}

void printClass(Class theClass) {
  print(theClass.subject);
  var classIdentifier = theClass.classIdentifier;
  print("TURMA $classIdentifier");
  for(var horary in theClass.schedule) {
    print(horary);
  }
}

bool includesLunch(int firstPeriod, int lastPeriod) {
  return firstPeriod <= 1 && lastPeriod > 1;
}

bool includesDinner(int firstPeriod, int lastPeriod) {
  return firstPeriod <= 3 && lastPeriod > 3;
}

bool intersects<E>(Set<E> a, Set<E> b) {
  return a.intersection(b).isNotEmpty;
}

int getNumOfIdleHours(Set<int> periodsWithClassInDay) {
  int firstPeriod = 6;
  int lastPeriod = 0;
  for(int period in periodsWithClassInDay) {
    firstPeriod = period < firstPeriod ? period : firstPeriod;
    lastPeriod = period > lastPeriod ? period : lastPeriod;
  }
  int numIdleHours = 0;
  if(includesLunch(firstPeriod, lastPeriod)) {
    numIdleHours += 2;
  }
  if(includesDinner(firstPeriod, lastPeriod)) {
    numIdleHours += 1;
  }
  for(int i = firstPeriod; i <= lastPeriod; i++) {
    if(!periodsWithClassInDay.contains(i)) {
      numIdleHours += 2;
    }
  }
  return numIdleHours;
}

double getHeuristic(List<Class> studentSchedule) {
  double heuristic = 0;
  Set<int> daysWithClass = new Set<int>();
  for(Class aClass in studentSchedule) {
    for(Horary horary in aClass.schedule) {
      daysWithClass.add(horary.weekDay);
    }
  }
  heuristic += daysWithClass.length;
  for(int weekDay in daysWithClass) {
    Set<int> periodsWithClassInDay = new Set<int>();
    for(Class aClass in studentSchedule) {
      for(Horary horary in aClass.schedule) {
        if(horary.weekDay == weekDay) {
          periodsWithClassInDay.add(horary.period);
        }
      }
    }
    int firstPeriodInDay = 6;
    int lastPeriodInDay = 1;
    for(int period in periodsWithClassInDay) {
      firstPeriodInDay = period < firstPeriodInDay ? period : firstPeriodInDay;
      lastPeriodInDay = period > lastPeriodInDay ? period : lastPeriodInDay;
    }
    int numIdleHours = getNumOfIdleHours(periodsWithClassInDay);
    heuristic += numIdleHours / 11.0;
  }
  return heuristic;
}

List<String> generateMustHaveSubjects(int maxNumSubjects) {
  var rng = new Random();
  int numSubjects = 3 + rng.nextInt(maxNumSubjects - 2);
  List<String> mustHaveSubjects = new List<String>();
  for(int i = 0; i < numSubjects; i++) {
    bool foundDifferentSubject = false;
    while(!foundDifferentSubject) {
      String attemptedNewSubject = subjectNames[rng.nextInt(subjectNames.length)].toUpperCase();
      bool subjectAlreadyInList = false;
      for(String subject in mustHaveSubjects) {
        if(subject.toUpperCase() == attemptedNewSubject) {
          subjectAlreadyInList = true;
          break;
        }
      }
      foundDifferentSubject = !subjectAlreadyInList;
      if(foundDifferentSubject) {
        mustHaveSubjects.add(attemptedNewSubject);
      }
    }
  }
  return mustHaveSubjects;
}

bool studentScheduleExists(List<int> proposedStudentSchedule, List<int> numOfClassesForEachSubject) {
  for(int i = 0; i < numOfClassesForEachSubject.length; i++) {
    if(proposedStudentSchedule[i] > numOfClassesForEachSubject[i]) {
      return false;
    }
  }
  return true;
}

List<List<Class>> refresh(int maxNumSubjects) {
  List<String> mustHaveSubjects = generateMustHaveSubjects(maxNumSubjects);
  List<List<Class>> allPossibleStudentSchedules = new List<List<Class>>();
  List<int> numOfClassesForEachSubject = new List<int>();
  int numOfSubjects = mustHaveSubjects.length;
  int maxNumOfClasses = 0;
  for (int i = 0; i < numOfSubjects; i++) {
    int maxIndexAllowedForThisSubject = offerBySubject[mustHaveSubjects[i]].length - 1;
    maxNumOfClasses = maxNumOfClasses > maxIndexAllowedForThisSubject
        ? maxNumOfClasses
        : maxIndexAllowedForThisSubject;
    numOfClassesForEachSubject.add(maxIndexAllowedForThisSubject);
  }
  List<int> allIntsFrom0ToMaxNumOfClasses = new List<int>();
  for(int i = 0; i < maxNumOfClasses; i++) {
    allIntsFrom0ToMaxNumOfClasses.add(i);
  }
  var allPossibleCombinationsOfClasses = Amalgams(numOfSubjects, allIntsFrom0ToMaxNumOfClasses);
  for(var combinationOfClasses in allPossibleCombinationsOfClasses()) {
    if(!studentScheduleExists(combinationOfClasses, numOfClassesForEachSubject)) {
      continue;
    } else {
      List<Class> studentSchedule = new List<Class>();
      bool isSelfIntersecting = false;
      for(int i = 0; i < numOfSubjects; i++) {
        if(studentSchedule.isEmpty) {
          studentSchedule.add(offerBySubject[mustHaveSubjects[i]][combinationOfClasses[i]]);
        } else {
          for(var aClass in studentSchedule) {
            if(intersects(aClass.schedule, offerBySubject[mustHaveSubjects[i]][combinationOfClasses[i]].schedule)) {
              isSelfIntersecting = true;
              break;
            }
          }
          if(isSelfIntersecting) {
            break;
          } else {
            studentSchedule.add(offerBySubject[mustHaveSubjects[i]][combinationOfClasses[i]]);
          }
        }
      }
      if(!isSelfIntersecting) {
        allPossibleStudentSchedules.add(studentSchedule);
      }
    }
  }
  List<GradedStudentSchedule> gradedStudentSchedules = new List<GradedStudentSchedule>();
  for(var studentSchedule in allPossibleStudentSchedules) {
    gradedStudentSchedules.add(new GradedStudentSchedule(studentSchedule));
  }
  List<GradedStudentSchedule> relevantGradedStudentSchedules = new List<GradedStudentSchedule>(4);
  relevantGradedStudentSchedules[0] = gradedStudentSchedules[0];
  relevantGradedStudentSchedules[1] = gradedStudentSchedules[1];
  relevantGradedStudentSchedules[2] = gradedStudentSchedules[2];
  relevantGradedStudentSchedules[3] = gradedStudentSchedules[3];
  for(var gradedStudentSchedule in gradedStudentSchedules) {
    if(relevantGradedStudentSchedules[0].heuristicsGrade > gradedStudentSchedule.heuristicsGrade) {
      relevantGradedStudentSchedules[0] = gradedStudentSchedule;
    }
    if(relevantGradedStudentSchedules[3].heuristicsGrade < gradedStudentSchedule.heuristicsGrade) {
      relevantGradedStudentSchedules[1] = relevantGradedStudentSchedules[2];
      relevantGradedStudentSchedules[2] = relevantGradedStudentSchedules[3];
      relevantGradedStudentSchedules[3] = gradedStudentSchedule;
    } else if(relevantGradedStudentSchedules[2].heuristicsGrade < gradedStudentSchedule.heuristicsGrade) {
      relevantGradedStudentSchedules[1] = relevantGradedStudentSchedules[2];
      relevantGradedStudentSchedules[2] = gradedStudentSchedule;
    } else if(relevantGradedStudentSchedules[1].heuristicsGrade < gradedStudentSchedule.heuristicsGrade) {
      relevantGradedStudentSchedules[1] = gradedStudentSchedule;
    }
  }
  List<List<Class>> returnList = new List<List<Class>>();
  for(var relevantGradedStudentSchedule in relevantGradedStudentSchedules) {
    returnList.add(relevantGradedStudentSchedule.studentSchedule);
  }
  return returnList;
}

List<List<bool>> generateTimeTable(Set<Horary> schedule) {
  List<List<bool>> timeTable = new List<List<bool>>(5);
  for(int i = 0; i < 5; i++) {
    timeTable[i] = new List<bool>(8);
    for(int j = 0; j < 8; j++) {
      timeTable[i][j] = false;
    }
  }
  for(Horary horary in schedule) {
    int tableTime = horary.period;
    if(horary.period > 1) {
      tableTime++;
    }
    if(horary.period > 3) {
      tableTime++;
    }
    timeTable[horary.weekDay][tableTime] = true;
  }
  return timeTable;
}

int classMain() {
  offer = generateOffer();  
  offerBySubject = getOfferBySubject(offer);
  // offerByDay = getOfferByDay(offer);
  // offerByPeriod = getOfferByPeriod(offer);
  // offerByHorary = getOfferByHorary(offer);
  //offerBySubject.forEach((a, b) => b.forEach((c) => printClass(c)));
  // List<String> mustHaveSubjects = new List<String>();
  // var studentSchedules = refresh(5);
  // var timeTable = generateTimeTable(studentSchedules[0][0].schedule);
  // for(int i = 0; i < 8; i++) {
  //   for(int j = 0; j < 5; j++) {
  //     stdout.write(" ");
  //     stdout.write(timeTable[j][i]);
  //   }
  //   stdout.write("\n");
  // }
  // for(int i = 0; i < 4; i++) {
  //   for(var aClass in studentSchedules[i]) {
  //     printClass(aClass);
  //   }
  //   print("");
  // }
  return 0;
}
