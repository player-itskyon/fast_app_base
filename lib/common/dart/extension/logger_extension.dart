

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common.dart';

extension LoggerContextExtention on BuildContext{

  static Logger logger = Logger();

  void loggerD(dynamic message){
    logger.d(message);
  }
  void loggerE(dynamic message){
    logger.e(message);
  }
  void loggerI(dynamic message){
    logger.i(message);
  }
}