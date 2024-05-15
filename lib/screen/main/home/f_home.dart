import 'package:fast_app_base/data/memory/todo_data_holder.dart';
import 'package:fast_app_base/screen/main/home/widget/w_no_contents.dart';
import 'package:flutter/material.dart';
import 'widget/w_todo_item.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TodoDataHolder.of(context).notifier,
        builder: (context, todoList, child) {
          //리스트를 리미트가 가장 빠른 순으로 정렬
          if (todoList.isNotEmpty) {
            todoList.sort((a, b) {
              if (a.limitTime.isBefore(b.limitTime)) {
                return -1;
              } else {
                return 1;
              }
            });
          }
          return todoList.isEmpty
              ? noContents()
              : Column(
                  children: [
                    ...todoList.map(
                      (todo) => TodoItem(todo: todo),
                    ),
                  ],
                );
        });
  }
}
