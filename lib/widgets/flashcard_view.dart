import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardView extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onToggle;

  FlashcardView({
    required this.flashcard,
    required this.showAnswer,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showAnswer ? flashcard.answer : flashcard.question,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onToggle,
              child: Text(showAnswer ? 'Hide Answer' : 'Show Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
