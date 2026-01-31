import 'package:flutter/material.dart';

Future<void> showAlert(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('확인'),
        ),
      ],
    ),
  );
}
// 다이얼로그를 닫아야 showDialog의 Future가 완료되기 때문에 context를 써야한다.
