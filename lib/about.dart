import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
            'This is a game about birds!\n'
            'You have to guess what bird I\'m thinking of.\n'
            'A green tile means you guessed the letter correctly in the correct place.\n'
            'A orange tile means the letter is correct, but in the wrong place.\n'
            'A red tile means the letter is not in the word.\n'
            'You have 5 guesses.\n\n'
            'Here are the valid bird names you can guess:\n',
          ),
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
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          key: const ValueKey(0),
          child: SizedBox(height: 50, child: Center(child: Text(_list[index]))),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),
            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (context) => PicPopup(bird: _list[index]),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pressed info ${_list[index]}')),
                  );
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.photo,
                label: 'View',
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete ${_list[index]}?'),
                      actions: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          //todo delete
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please don\'t delete the ${_list[index]} you naughty naughty man.',
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(color: Colors.grey);
      },
    );
  }
}

class PicPopup extends StatelessWidget {
  const PicPopup({super.key, required this.bird});

  final String bird;

  @override
  Widget build(BuildContext context) {
    final String image = 'assets/${bird}.gif';

    return AlertDialog(
      title: Center(child: Text('${bird}')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Image.asset(image)],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Dismiss'),
          ),
        ),
      ],
    );
  }
}
