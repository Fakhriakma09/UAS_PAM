import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/model.dart';

class DetailPage extends StatefulWidget {
  final PostData postData;

  const DetailPage({Key? key, required this.postData}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isRed = true;

  void _toggleBackgroundColor() {
    setState(() {
      _isRed = !_isRed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail Page'),
          backgroundColor: Colors.blue,
        ),
        body: GestureDetector(
          onTap: _toggleBackgroundColor,
          child: Container(
            color: _isRed ? Colors.white : Color.fromARGB(188, 16, 1, 1),
            width: 1350,
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Do: ${widget.postData.dos}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _isRed ? Colors.black : Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Activity: ${widget.postData.listactivity}',
                    style: TextStyle(
                        fontSize: 20,
                        color: _isRed ? Colors.black : Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ToDo: ${widget.postData.todo}',
                    style: TextStyle(
                        fontSize: 20,
                        color: _isRed ? Colors.black : Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Status: ${widget.postData.status ? "Completed" : "Pending"}',
                    style: TextStyle(
                        fontSize: 20,
                        color: _isRed ? Colors.black : Colors.white,),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
