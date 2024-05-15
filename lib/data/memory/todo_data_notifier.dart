import 'package:fast_app_base/data/memory/todo_status.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:flutter/cupertino.dart';

class TodoDataNotifier extends ValueNotifier<List<Todo>> {
  TodoDataNotifier() : super([]);

  void addTodo(Todo todo) {
    value.add(todo);
    notifyListeners();
  }

  void updateStatusTodo(int id, TodoStatus status) {
    Todo? todo = getTodoById(id);
    if (todo != null) {
      todo.status = status;
      todo.modifyTime = DateTime.now();
      todo.isAlarmActive = false;
      todo.alarmList = [false, false, false, false, false];
    }
    notifyListeners();
  }

  void remove(Todo todo) {
    value.remove(todo);
    notifyListeners();
  }

  Todo? getTodoById(int id) {
    return value.firstWhere((todo) => todo.id == id);
  }
}

//  void changeBmiModel(){
//     bmiModel.value = bmiCalculContoller.bmiModelList.value.firstWhere((element) =>
//     element.time == dateTime.value, //선택된 날짜와 element 의 날짜를 대조하여 첫번째 일치값을 가져온다.
//     orElse: ()=> BmiModel(bmi: 0, weight: 0, time: dateTime.value, diet: [])); //만약 일치값이 없다면 모델에 기본값을 넣어 새로운 모델을 리턴시킨다.
//
//     dietList.value = bmiModel.value.diet;
//     print(bmiModel.value.time);
//   }
