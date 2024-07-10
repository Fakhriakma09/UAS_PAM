import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/detaillist.dart';
import 'package:flutter_application_8/view/tambahdata.dart';
import 'package:flutter_application_8/model/model.dart';
import 'package:flutter_application_8/controller/controller.dart';
import 'package:flutter_application_8/view/update.dart';
import 'package:flutter_application_8/view/search.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Type something to search'),
    );
  }
}

class MainDisplayPageApi extends StatefulWidget {
  const MainDisplayPageApi({Key? key}) : super(key: key);

  @override
  _MainDisplayPageApiState createState() => _MainDisplayPageApiState();
}

class _MainDisplayPageApiState extends State<MainDisplayPageApi> {
  final PostApiServicesDio postApiServicesDio = PostApiServicesDio();
  late Future<List<PostData>> postData;

  @override
  void initState() {
    super.initState();
    postData = postApiServicesDio.getPostData();
  }

  void _addPost(String dos, String listActivity, String toDo) async {
    try {
      String response = await postApiServicesDio.sendRequestPost(
        dos,
        listActivity,
        toDo,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
      setState(() {
        postData = postApiServicesDio.getPostData();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('Failed to upload data: '),
              Text(
                e.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _updatePost(
      String id, String dos, String listactivity, String toDo) async {
    try {
      String response = await postApiServicesDio.UpdateRequestPost(
          dos, listactivity, toDo, id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
      setState(() {
        postData = postApiServicesDio.getPostData();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text('Failed to update data: '),
              Text(
                e.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _deletePost(String id) async {
    try {
      String response = await postApiServicesDio.delPostData(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.toString())),
      );
      setState(() {
        postData = postApiServicesDio.getPostData();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete data: $e'),
        ),
      );
    }
  }

  void _toggleCompleted(String id, bool currentStatus) async {
    try {
      String response =
          await postApiServicesDio.toggleCompleted(id, currentStatus);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
      setState(() {
        postData = postApiServicesDio.getPostData();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update status: $e'),
        ),
      );
    }
  }

  void _navigateToAddDataPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDataPage(
          addPostCallback: _addPost,
        ),
      ),
    );
  }

  void _navigateUpdatePage(PostData postData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDataPage(
          updatePostCallback: _updatePost,
          postData: postData,
        ),
      ),
    );
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
        title: Row(
          children: [
            Text('To-DO List'),
            SizedBox(width: 7),
            Image.asset(
              'lib/assets/Gambar/tolist.png',
              height: 50,
              width: 50,
            ),
            SizedBox(width: 7),
            ElevatedButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              child: Text('Search'),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        color: const Color.fromARGB(255, 41, 2, 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<PostData>>(
                future: postData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://vectorified.com/images/no-data-icon-10.png',
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error,
                                    size: 50, color: Colors.red),
                          ),
                          const SizedBox(height: 20),
                          Text('Error: ${snapshot.error}'),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<PostData> snapshotData =
                        snapshot.data as List<PostData>;

                    return ListView.builder(
                      itemCount: snapshotData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              _navigateToDetailPage(snapshotData[index]),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('lib/assets/Gambar/imag.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: snapshotData[index].status,
                                  onChanged: (bool? value) {
                                    _toggleCompleted(snapshotData[index].id,
                                        snapshotData[index].status);
                                  },
                                ),
                                subtitle: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 50.0, left: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Do: ${snapshotData[index].dos}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 12),
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Container(
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Text(
                                            'ListActivity: ${snapshotData[index].listactivity}',
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.8),
                                                fontSize: 12),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            'ToDo: ${snapshotData[index].todo}',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                backgroundColor: Colors.black
                                                    .withOpacity(0.8),
                                                fontSize: 12),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: Colors.amber.withOpacity(0.8),
                                      width: 38,
                                      height: 38,
                                      child: IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: Colors.blueAccent,
                                        onPressed: () => _navigateUpdatePage(
                                            snapshotData[index]),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.redAccent.withOpacity(0.8),
                                      width: 38,
                                      height: 38,
                                      child: IconButton(
                                        icon: const Icon(Icons.delete),
                                        color:
                                            Color.fromARGB(255, 108, 104, 104),
                                        onPressed: () =>
                                            _deletePost(snapshotData[index].id),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddDataPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
