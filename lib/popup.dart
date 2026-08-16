import 'package:flutter/material.dart';

/// Flutter code sample for [AlertDialog].

import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  const Popup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('You WON!'),
      content: const Text('Congratulations!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
