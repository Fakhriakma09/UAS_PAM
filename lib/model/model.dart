class PostData {
  String dos;
  String listactivity;
  bool status; 
  String todo ;
  String id;

  PostData({
    required this.dos,
    required this.listactivity,
    required this.status,
    required this.todo,
    required this.id
  });

  factory PostData.fromJson(Map<String, dynamic> object) {
    return PostData(
      dos: object["dos"],
      listactivity: object['listactivity'],
      status: object['status'],
      todo: object['todo'],
      id: object["id"]

    );
  }
}