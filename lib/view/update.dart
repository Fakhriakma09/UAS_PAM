import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/model.dart'; // Make sure to import your model

class UpdateDataPage extends StatelessWidget {
  final TextEditingController dosController;
  final TextEditingController listActivityController;
  final TextEditingController toDoController;

  final Function(String, String, String, String) updatePostCallback;
  final PostData postData;

  UpdateDataPage({
    Key? key,
    required this.updatePostCallback,
    required this.postData,
  })  : dosController = TextEditingController(text: postData.dos),
        listActivityController = TextEditingController(text: postData.listactivity),
        toDoController = TextEditingController(text: postData.todo),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
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
              controller: listActivityController,
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
                    listActivityController.text.isEmpty ||
                    toDoController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form tidak boleh kosong')),
                  );
                  return;
                }
                updatePostCallback(
                  postData.id,
                  dosController.text,
                  listActivityController.text,
                  toDoController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
