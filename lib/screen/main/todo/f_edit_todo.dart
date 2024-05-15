import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/memory/todo_data_holder.dart';
import '../../../data/memory/vo_todo.dart';

class EditTodoFragment extends StatefulWidget {
  Todo? todo;

  EditTodoFragment({super.key, this.todo});

  @override
  State<EditTodoFragment> createState() => _EditTodoFragmentState();
}

class _EditTodoFragmentState extends State<EditTodoFragment> {
  bool isRepeat = false;
  bool isAlarm = false;

  List alarmTime = [60, 30, 10, 5, 1];
  List<bool> alarmTimeTF = [false, false, false, false, false];

  TextEditingController titleCtr = TextEditingController();
  TextEditingController subCtr = TextEditingController();

  DateTime? limitTime;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      titleCtr.text = widget.todo!.title;
      subCtr.text = widget.todo!.subs ?? "";
      limitTime = widget.todo!.limitTime;
      if (widget.todo!.alarmList != null || widget.todo!.alarmList!.isNotEmpty) {
        alarmTimeTF = widget.todo!.alarmList!;
      }
      isAlarm = widget.todo!.isAlarmActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu_book,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.fitness_center,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.restaurant_rounded,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.music_note,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Column(
                children: [
                  TextField(
                    controller: titleCtr,
                    decoration: const InputDecoration(
                      hintText: "제목",
                      hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.grey),
                    ),
                  ),
                  const Height(15),
                  TextField(
                    controller: subCtr,
                    decoration: const InputDecoration(
                      hintText: "설명",
                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.grey),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "목표시간".text.size(16).color(AppColors.darkGrey).make(),
                      InkWell(
                        onTap: () async {
                          DateTime initTime;
                          if (limitTime == null) {
                            initTime = DateTime.now();
                          } else {
                            initTime = limitTime!;
                          }
                          print('initTime : $initTime');
                          showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  currentDate: initTime,
                                  lastDate: initTime.add(
                                    const Duration(
                                      days: 30,
                                    ),
                                  ),
                                  useRootNavigator: false,
                                  barrierDismissible: false,
                                  initialEntryMode: DatePickerEntryMode.calendarOnly)
                              .then((selectedDate) {
                            if (selectedDate != null) {
                              limitTime = selectedDate;

                              showTimePicker(context: context, initialTime: initTime.getTimeOfDay, barrierDismissible: false)
                                  .then((selectedTime) {
                                if (selectedTime != null) {
                                  limitTime = limitTime!.applied(selectedTime);
                                  if (limitTime!.isAfter(DateTime.now())) {
                                    setState(() {});
                                    return;
                                  } else {
                                    context.showSnackbar("과거의 시간은 선택할 수 없습니다.");
                                  }
                                } else {
                                  limitTime = DateTime.now();
                                }
                              });
                            } else {
                              limitTime = DateTime.now();
                              return;
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            (limitTime?.formattedAmPm ?? '').text.make(),
                            Container(
                              height: 60,
                              width: 40,
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                              child: "${limitTime?.formattedHour ?? ""}".text.size(20).make(),
                            ),
                            ":".text.bold.size(25).make(),
                            Container(
                              height: 60,
                              width: 40,
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                              child: "${limitTime?.formattedMinute ?? ""}".text.size(20).make(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "반복".text.make(),
                      CupertinoSwitch(value: isRepeat, onChanged: (value){
                        setState(() {
                          isRepeat = value;
                        });
                      }),

                    ],
                  ),*/
                  const Height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "미리알림".text.size(16).color(AppColors.darkGrey).make(),
                      CupertinoSwitch(
                          value: isAlarm,
                          onChanged: (value) {
                            setState(() {
                              isAlarm = value;
                            });
                          }),
                    ],
                  ),
                  const Height(20),
                  Visibility(
                    visible: isAlarm,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [...alarmTime.mapIndexed((currentValue, index) => AlarmUI(index)).toList()],
                    ),
                  )
                ],
              ).pSymmetric(h: 20)
            ],
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.blue),
                  child: Center(
                      child: widget.todo == null
                          ? "추가하기".text.color(Colors.white).size(20).bold.make()
                          : "수정하기".text.color(Colors.white).size(20).bold.make()),
                ),
                onPressed: () {
                  if (titleCtr.text.isEmpty) {
                    context.showSnackbar("일정 제목이 입력되지 않았습니다.");
                    return;
                  }

                  if (limitTime != null) {
                    TodoDataHolder.of(context).notifier.addTodo(Todo(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: titleCtr.text,
                        subs: subCtr.text,
                        limitTime: limitTime!,
                        isAlarmActive: isAlarm,
                        alarmList: alarmTimeTF));
                    Nav.pop(context);
                  } else {
                    context.showSnackbar("목표시간이 설정되지 않았습니니다.");
                  }
                },
              ).pOnly(bottom: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget RepeatUI() {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
        )
      ],
    );
  }

  Widget AlarmUI(int index) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              alarmTimeTF[index] = !alarmTimeTF[index];
            });
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blue, width: 3),
                color: alarmTimeTF[index] ? AppColors.blue : Colors.white),
            child: Center(
              child: "${alarmTime[index]}M".text.color(alarmTimeTF[index] ? Colors.white : AppColors.blue).bold.make(),
            ),
          ),
        )
      ],
    );
  }
}
