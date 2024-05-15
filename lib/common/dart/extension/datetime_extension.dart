import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('dd/MM/yyyy').format(this);

  String get formattedTime => DateFormat('HH:mm').format(this);

  String get formattedDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get formattedDateTime2 => DateFormat('yy/MM/dd  a hh:mm').format(this);


  DateTime applied(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  String get formattedAmPm => DateFormat('aa').format(this);

  String get formattedHour => DateFormat('hh').format(this);

  String get formattedMinute => DateFormat('mm').format(this);

  TimeOfDay get getTimeOfDay => TimeOfDay(hour: this.hour, minute: this.minute);

  String get relativeDays {
    final diffDays = this. difference(DateTime.now().onlyDate).inDays;
    final isNegative = diffDays.isNegative;

    final checkCondition = (diffDays, isNegative);

    return switch (checkCondition){
    (0, _)=> "오늘까지",
    (1, _) => "내일까지",
    (_, true) => "$diffDays일 지남",
    _=> "$diffDays일 남음"
    };
  }

  DateTime get onlyDate => DateTime(year, month, day);

}
