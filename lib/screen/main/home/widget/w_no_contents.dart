import 'package:flutter/material.dart';

import '../../../../common/common.dart';

Widget noContents() {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info, size: 80,),
        const Height(20),
        "등록된 일정이 없습니다.".text.size(20).make(),
      ],
    ),
  );
}