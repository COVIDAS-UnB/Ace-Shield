import 'package:flutter/material.dart';
import './models/Class.dart';

const DUMMY_CLASSES = const [
  Class(
    subject: 'Álgebra Linear',
    classIdentifier: 'A',
    numOfCreds: 6,
    infectedPeople: 0,
    schedule: [
      [1],
      [2],
    ],
  ),
  Class(
    subject: 'Cálculo 1',
    classIdentifier: 'B',
    numOfCreds: 6,
    infectedPeople: 2,
    schedule: [
      [1],
      [2],
    ],
  ),
  Class(
    subject: 'Introdução a Economia',
    classIdentifier: 'B',
    numOfCreds: 4,
    infectedPeople: 0,
    schedule: [
      [1],
      [2],
    ],
  ),
  Class(
    subject: 'Estruturas de Dados',
    classIdentifier: 'A',
    numOfCreds: 6,
    infectedPeople: 1,
    schedule: [
      [1],
      [2],
    ],
  ),
  Class(
    subject: 'Circuitos Lógicos',
    classIdentifier: 'A',
    numOfCreds: 4,
    infectedPeople: 0,
    schedule: [
      [1],
      [2],
    ],
  ),
  // Class(
  //   subject: 'Física 1',
  //   classIdentifier: 'A',
  //   numOfCreds: 4,
  //   infectedPeople: 0,
  //   schedule: [
  //     [1],
  //     [2],
  //   ],
  // ),
];
