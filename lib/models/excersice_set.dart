import 'dart:ffi';

import 'package:flutter/material.dart';

import 'excersice.dart';
import 'excersice_sets.dart';

enum ExerciseType { low, mid, hard }

String getExerciseName(ExerciseType type) {
  switch (type) {
    case ExerciseType.low:
      return "Sơ cấp";
      break;
    case ExerciseType.mid:
      return "Trung bình";
      break;
    case ExerciseType.hard:
      return "Nâng cao";
      break;
    default:
      return 'All';
      break;
  }
}

class ExerciseSet {
  final String name;
  final List<Exercise> exercises;
  final String imageUrl;
  final ExerciseType exerciseType;
  final Color color;

  const ExerciseSet({
    required this.name,
    required this.exercises,
    required this.imageUrl,
    required this.exerciseType,
    required this.color,
  });

  String get totalDuration {
    final duration = exercises.fold(
      Duration.zero,
      (dynamic previous, element) => previous + element.duration,
    );

    return duration.inMinutes.toString();
  }

  double get totalCalo {
    final calo = exercises.fold(
        0, (dynamic previousValue, element) => previousValue + element.calo);
    return calo;
  }
}
