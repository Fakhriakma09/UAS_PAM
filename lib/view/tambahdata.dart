
import 'package:flutter/material.dart';

class AddDataPage extends StatelessWidget {
  final TextEditingController dosController = TextEditingController();
  final TextEditingController ListActivityController = TextEditingController();
  final TextEditingController toDoController = TextEditingController();

  final Function(String, String, String) addPostCallback;

  AddDataPage({Key? key, required this.addPostCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: dosController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Do',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ListActivityController,
            
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ListActivity',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: toDoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'ToDo',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (dosController.text.isEmpty ||
                    ListActivityController.text.isEmpty ||
                    toDoController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('form tidak boleh kosong')),
                  );
                  return;
                }
                addPostCallback(
                  dosController.text,
                  ListActivityController.text,
                  toDoController.text,
                );
                Navigator.pop(context); 
              },
              child: const Text('Add Data'),
            ),
          ],
        ),
      ),
    );
  }
}
