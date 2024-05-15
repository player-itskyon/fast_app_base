import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/dialog/d_confirm.dart';
import 'package:fast_app_base/screen/main/todo/s_edit_todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/memory/todo_status.dart';
import '../../../../data/memory/vo_todo.dart';

class TodoItem extends StatefulWidget {
  Todo todo;

  TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.todo.id),
      onDismissed: (direction) {
        TodoDataHolder.of(context).notifier.remove(widget.todo);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red.withOpacity(0.8),
        child: Row(
          children: [
            EmptyExpanded(),
            Icon(Icons.delete, color: Colors. white,),
            Width(30)
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Nav.push(EditTodo(
            todo: widget.todo,
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              onPressed: () async {
                if (widget.todo.status == TodoStatus.incomplete) {
                  final confirmDialogResult = await ConfirmDialog(
                    "완료 처리 하시겠습니까?\n완료 처리는 되돌릴 수 없습니다.",
                    context: context,
                    buttonText: "완료",
                    cancelButtonText: "취소",
                  ).show();
                  if (confirmDialogResult != null && confirmDialogResult.isSuccess) {
                    TodoDataHolder.of(context).notifier.updateStatusTodo(widget.todo.id, TodoStatus.complete);
                  } else if (confirmDialogResult != null && confirmDialogResult.isFailure) {
                    logger.i(widget.todo);
                  }
                } else if (widget.todo.status == TodoStatus.complete) {
                  context.showSnackbar("이미 완료 처리된 항목은 되돌릴 수 없습니다.");
                  logger.i(widget.todo);
                }
              },
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.todo.status == TodoStatus.complete ? AppColors.blue : Colors.white,
                    border: Border.all(color: AppColors.blue, width: 5),
                  ),
                  child: widget.todo.status == TodoStatus.complete
                      ? Center(
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 35,
                          ),
                        )
                      : Container()),
            ),
            Width(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.todo.title.text.bold.size(15).make(),
                widget.todo.subs.text.size(12).color(AppColors.darkGrey).make(),
              ],
            ),
            EmptyExpanded(),
            GestureDetector(
              onTap: () async {},
              child: Icon(
                Icons.alarm,
                color: widget.todo.isAlarmActive ? Colors.red : Colors.grey,
              ),
            ),
            Width(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.todo.limitTime.relativeDays.text.make(),
                (widget.todo.limitTime.formattedDateTime2).text.make(),
              ],
            ).pOnly(right: 20)
          ],
        ),
      ),
    );
  }
}
