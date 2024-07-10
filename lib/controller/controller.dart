import 'package:dio/dio.dart';
import 'package:flutter_application_8/model/model.dart';

class PostApiServicesDio {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://66769fda145714a1bd724d0e.mockapi.io/product',
  ));

  Future<List<PostData>> getPostData() async {
    try {
      final response = await _dio.get('/beranda');
      print(response);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => PostData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<String> sendRequestPost(String dos, String listactivity, String todo) async {
    try {
      final response = await _dio.post('/beranda', data: {
        'dos': dos,
        'listactivity': listactivity,
        'todo': todo,
        'status': false,
      });
      if (response.statusCode == 201) {
        return '201 : Data berhasil ditambahkan!';
      } else {
        throw Exception('Failed to upload data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to upload data: $e');
    }
  }

  Future<String> delPostData(String id) async {
    try {
      final response = await _dio.delete('/beranda/$id');
      if (response.statusCode == 200) {
        return '200 : Data ke-$id berhasil dihapus!';
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  Future<String> toggleCompleted(String id, bool currentStatus) async {
    try {
      final response = await _dio.put('/beranda/$id', data: {
        'status': !currentStatus,
      });
      if (response.statusCode == 200) {
        return 'selesai';
      } else {
        throw Exception('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  Future<String> UpdateRequestPost(String dos, String listactivity, String todo, String id) async {
    try {
      final response = await _dio.put('/beranda/$id', data: {
        'dos': dos,
        'listactivity': listactivity,
        'todo': todo,
        'status': false,
      });
      if (response.statusCode == 200) {
        return '200 : Data berhasil diperbarui!';
      } else {
        throw Exception('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<List<PostData>> getPostDatas(String query) async {
    try {
      final response = await _dio.get('/beranda');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<PostData> allPosts = data.map((json) => PostData.fromJson(json)).toList();
        return allPosts.where((post) => post.dos.contains(query)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
