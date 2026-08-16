import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'game.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('How to play Birdle'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(child: getAboutPage()),
    );
  }
}

Widget getAboutPage() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: 400,
      child: Column(
        children: [
          Text(
            'This is a game about birds! \n'
            'You have to guess what bird I\'m thinking of...',
          ),
          Text('Here are the valid bird names you can guess:'),
          Expanded(child: Scroller(list: allLegalGuesses)),
        ],
      ),
    ),
  );
}

class Scroller extends StatelessWidget {
  const Scroller({super.key, required this._list});

  final List<String> _list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(height: 50, child: Center(child: Text(_list[index])));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 1,
          child: ColoredBox(color: Colors.blueGrey),
        );
      },
    );
  }
}
