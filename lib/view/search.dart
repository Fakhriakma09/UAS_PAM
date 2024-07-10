import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/model.dart';
import 'package:flutter_application_8/controller/controller.dart';
import 'package:flutter_application_8/view/detaillist.dart';

class SearchPage extends StatefulWidget {
  final String query;

  SearchPage({required this.query});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PostApiServicesDio _apiService = PostApiServicesDio();
  late Future<List<PostData>> _postData;

  @override
  void initState() {
    super.initState();
    _postData = _apiService.getPostDatas(widget.query);
  }

  void _navigateToDetailPage(PostData postData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(postData: postData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: FutureBuilder<List<PostData>>(
        future: _postData,
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
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/Gambar/imag.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        'Do: ${results[index].dos}',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'List: ${results[index].listactivity}',
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'ToDo: ${results[index].todo}',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                      onTap: () {
                        _navigateToDetailPage(results[index]);
                      },
                    ),
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
