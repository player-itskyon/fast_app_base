import 'package:fast_app_base/data/memory/todo_status.dart';

class Todo {
  final int id;
  String title;
  String subs;
  final DateTime createdTime;
  DateTime? modifyTime;
  final DateTime limitTime;
  bool isAlarmActive;
  TodoStatus status;
  List<bool> alarmList;

  Todo({
    required this.id,
    required this.title,
    this.subs = "",
    this.modifyTime,
    required this.limitTime,
    required this.isAlarmActive,
    this.alarmList = const <bool>[false, false, false, false, false],
    this.status = TodoStatus.incomplete,
  }) : createdTime = DateTime.now();

  @override
  String toString() {
    return 'Todo{id: $id, \ntitle: $title, \nsubs: $subs, \ncreatedTime: $createdTime, \nmodifyTime: $modifyTime, \nlimitTime: $limitTime, \nisAlarmActive: $isAlarmActive, \nstatus: $status, \nalarmList: $alarmList}';
  }
}
