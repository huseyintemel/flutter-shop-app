import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final BuildContext ctx;
  final String title;
  final String content;
  final Function rejectHandler;
  final Function acceptHandler;


  Alert({
    required this.ctx,
    required this.title,
    required this.content,
    required this.rejectHandler,
    required this.acceptHandler,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text('No'),
          onPressed: () => rejectHandler(),
          style: TextButton.styleFrom(
            primary: Colors.blueGrey.shade700,
          ),
        ),
        TextButton(
          child: const Text('Yes'),
          onPressed: () => acceptHandler(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.redAccent,
            primary: Colors.white,
          ),
        ),
      ],
    );
  }
}
