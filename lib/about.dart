import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            context.go('/');
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
    child: Column(
      children: [
        Text(
          'This is a game about birds! '
          'You have to guess what bird I\'m thinking of...',
        ),
      ],
    ),
  );
}

// @override
// Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         for (final guess in _game.guesses)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               for (var letter in guess)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 2.5,
//                     vertical: 2.5,
//                   ),
//                   child: Tile(letter.char, letter.type),
//                 ),
//             ],
//           ),
//         GuessInput(
//           onSubmitGuess: (String guess) {
//             setState(() {
//               _game.guess(guess);
//             });
//           },
//         ),
//       ],
//     ),
//   );
// }
