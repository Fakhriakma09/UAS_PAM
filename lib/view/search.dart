import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/model.dart';
import 'package:flutter_application_8/controller/controller.dart';

class SearchPage extends StatelessWidget {
  final String query;

  SearchPage({required this.query});

  final PostApiServicesDio _apiService = PostApiServicesDio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<PostData>>(
        future: _apiService.getPostDatas(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          } else {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                  title: Text(results[index].dos),
                  subtitle: Container(child: Row(
                    children: [
                      Text(results[index].listactivity),
                      Text(results[index].todo)
                    ],
                  )),
                  trailing: Icon(
                    results[index].status ? Icons.check_circle : Icons.cancel,
                    color: results[index].status ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // Handle item tap if needed
                  },
                ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
