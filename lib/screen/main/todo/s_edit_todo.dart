import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/data/memory/vo_todo.dart';
import 'package:fast_app_base/screen/main/todo/f_edit_todo.dart';
import 'package:fast_app_base/screen/main/todo/vo_todo_detail.dart';
import 'package:flutter/material.dart';

class EditTodo extends StatefulWidget {
  Todo? todo;

  EditTodo({super.key, this.todo});

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "일정 추가".text.make(),
      ),
      body: EditTodoFragment(todo: widget.todo,),
    );
  }
}
