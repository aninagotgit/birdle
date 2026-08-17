import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'about.dart';
import 'game.dart';

void main() => runApp(const MainApp());

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Birdle'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/about');
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Center(child: GamePage()),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key});

  final String letter;
  final HitType hitType;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.partial => Colors.grey,
          HitType.miss => Colors.red,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<StatefulWidget> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Game _game = Game();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (final guess in _game.guesses)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var letter in guess)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2.5,
                        vertical: 2.5,
                      ),
                      child: Tile(letter.char, letter.type),
                    ),
                ],
              ),
            GuessInput(
              onSubmitGuess: (String guess) {
                setState(() {
                  _game.guess(guess);
                });
                if (_game.didWin) {
                  showDialog(
                    context: context,
                    builder: (context) => WinPopup(
                      bird: _game.hiddenWord.toString(),
                      onPlayAgain: () {
                        setState(() {
                          _game.resetGame();
                        });
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GuessInput extends StatefulWidget {
  const GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;

  @override
  State<GuessInput> createState() => _GuessInputState();
}

class _GuessInputState extends State<GuessInput> {
  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  void _onSubmit() {
    widget.onSubmitGuess(_textEditingController.text.trim());
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 5,
                focusNode: _focusNode,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
                controller: _textEditingController,
                onSubmitted: (_) {
                  _onSubmit();
                },
              ),
            ),
          ),
          IconButton(
            iconSize: 40,
            icon: const Icon(Icons.arrow_circle_up),
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }
}

class WinPopup extends StatelessWidget {
  const WinPopup({super.key, required this.bird, required this.onPlayAgain});

  final String bird;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    final (String image, String description) = switch (bird) {
      'goose' => ('assets/goose.webp', 'A bird that honks.\n'),
      'stork' => ('assets/stork.gif', 'A bird with long legs.\n'),
      'robin' => ('assets/robin.gif', 'A bird that sings songs\n'),
      _ => throw UnimplementedError('No bird gif loaded for your bird'),
    };

    return AlertDialog(
      title: Center(child: Text('You WON!')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text(bird), Text(description), Image.asset(image)],
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              onPlayAgain();
            },
            child: const Text('Play again'),
          ),
        ),
      ],
    );
  }
}
