import 'package:flutter/material.dart';

class FlashcardForm extends StatefulWidget {
  final String? initialQuestion;
  final String? initialAnswer;
  final Function(String, String) onSave;

  FlashcardForm(
      {this.initialQuestion, this.initialAnswer, required this.onSave});

  @override
  _FlashcardFormState createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.initialQuestion ?? '');
    _answerController = TextEditingController(text: widget.initialAnswer ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.initialQuestion == null ? 'Add Flashcard' : 'Edit Flashcard'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
              validator: (value) => value!.isEmpty ? 'Enter a question' : null,
            ),
            TextFormField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer'),
              validator: (value) => value!.isEmpty ? 'Enter an answer' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(_questionController.text, _answerController.text);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
