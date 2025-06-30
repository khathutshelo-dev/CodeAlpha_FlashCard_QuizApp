import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_form.dart';
import '../widgets/flashcard_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flashcard> flashcards = [
    Flashcard(
        question: 'What is Flutter?',
        answer: 'An open-source UI SDK by Google.'),
    Flashcard(question: 'What language is used in Flutter?', answer: 'Dart.'),
    Flashcard(
        question: 'What widget is used for layout in Flutter?',
        answer: 'Column, Row, Stack.'),
    Flashcard(
        question: 'What does SDK stand for?',
        answer: 'Software Development Kit.'),
    Flashcard(
        question: 'What is a StatelessWidget?',
        answer: 'A widget that doesn’t change state during runtime.'),
    Flashcard(
        question: 'What is a StatefulWidget?',
        answer: 'A widget that can rebuild when its state changes.'),
    Flashcard(
        question: 'What does hot reload do?',
        answer: 'It reloads code changes without restarting the app.'),
    Flashcard(
        question: 'How do you navigate between screens in Flutter?',
        answer: 'Using Navigator.push and Navigator.pop.'),
    Flashcard(
        question: 'What is MaterialApp?',
        answer:
            'A convenience widget that wraps a number of widgets for Material Design.'),
    Flashcard(
        question: 'What is Scaffold?',
        answer: 'A layout structure with appBar, body, drawer, etc.'),
    Flashcard(
        question: 'What is a widget in Flutter?',
        answer: 'A basic building block of a Flutter UI.'),
    Flashcard(
        question: 'What is setState()? ',
        answer:
            'A method to update the UI when data changes in StatefulWidget.'),
    Flashcard(
        question: 'What is the main() function in Dart?',
        answer: 'The entry point of every Dart application.'),
    Flashcard(
        question: 'What package manager does Flutter use?',
        answer: 'pub (uses pubspec.yaml).'),
    Flashcard(
        question: 'What is pubspec.yaml?',
        answer: 'A file to manage dependencies and project configuration.'),
    Flashcard(
        question: 'What is async and await in Dart?',
        answer: 'Used for handling asynchronous code.'),
    Flashcard(
        question: 'What is null safety in Dart?',
        answer: 'A feature to prevent null reference errors.'),
    Flashcard(
        question: 'How do you create a list in Dart?',
        answer: 'Using square brackets, e.g., List myList = [1, 2, 3];'),
    Flashcard(
        question: 'What is the use of ElevatedButton?',
        answer: 'To create a clickable button with elevation.'),
    Flashcard(
        question: 'What is the use of TextField?',
        answer: 'To get user input as text.'),
  ];

  int currentIndex = 0;
  bool showAnswer = false;

  void _addFlashcard(String question, String answer) {
    setState(() {
      flashcards.add(Flashcard(question: question, answer: answer));
    });
  }

  void _editFlashcard(int index, String question, String answer) {
    setState(() {
      flashcards[index] = Flashcard(question: question, answer: answer);
    });
  }

  void _deleteFlashcard(int index) {
    setState(() {
      flashcards.removeAt(index);
      if (currentIndex >= flashcards.length && flashcards.isNotEmpty) {
        currentIndex = flashcards.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasCards = flashcards.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Quiz App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => FlashcardForm(
                onSave: (q, a) => _addFlashcard(q, a),
              ),
            ),
          )
        ],
      ),
      body: hasCards
          ? Column(
              children: [
                Expanded(
                  child: FlashcardView(
                    flashcard: flashcards[currentIndex],
                    showAnswer: showAnswer,
                    onToggle: () {
                      setState(() {
                        showAnswer = !showAnswer;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: currentIndex > 0
                          ? () => setState(() {
                                currentIndex--;
                                showAnswer = false;
                              })
                          : null,
                      child: Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: currentIndex < flashcards.length - 1
                          ? () => setState(() {
                                currentIndex++;
                                showAnswer = false;
                              })
                          : null,
                      child: Text('Next'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => FlashcardForm(
                          initialQuestion: flashcards[currentIndex].question,
                          initialAnswer: flashcards[currentIndex].answer,
                          onSave: (q, a) => _editFlashcard(currentIndex, q, a),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text("Delete"),
                      onPressed: () => _deleteFlashcard(currentIndex),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            )
          : Center(child: Text('No flashcards yet. Add one!')),
    );
  }
}
