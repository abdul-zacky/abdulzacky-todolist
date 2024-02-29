import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _textEditingController = TextEditingController();
  String _savedText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Enter your text'),
            // This callback is triggered when the user submits the text
            onSubmitted: (value) {
              _saveText();
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _saveText();
            },
            child: Text('Save Text'),
          ),
          SizedBox(height: 16),
          Text('Saved Text: $_savedText'),
        ],
      ),
    );
  }

  // Function to save the text
  void _saveText() {
    setState(() {
      _savedText = _textEditingController.text;
    });
    // Clear the text field
    _textEditingController.clear();
    // Update the input text field with the saved text
    _textEditingController.text = _savedText;
  }
}