import 'package:flutter/material.dart';

class TodoDetail {
  final DateTime dateTime;
  final String title;
  final String sub;
  final TimeOfDay limitTime;
  final bool isAlarmActive;
  final String category;

  TodoDetail(
      {required this.dateTime,
      required this.title,
      required this.sub,
      required this.limitTime,
      required this.isAlarmActive,
      required this.category});
}
