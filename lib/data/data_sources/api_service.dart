import 'package:dio/dio.dart';
import 'package:dreaml_ab/data/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://jsonplaceholder.org/posts';

Future<List<PostModel>> fetchPosts({int page = 1, int limit = 20}) async {
  try {
    final response = await _dio.get(_baseUrl);
    if (response.statusCode == 200) {
      final List data = response.data;
      
      final int start = (page - 1) * limit;
      if (start >= data.length) return []; 

      final List<PostModel> posts = data
          .skip(start)
          .take(limit)
          .map((json) => PostModel.fromJson(json))
          .toList();

      print("Page: $page, Returning posts: ${posts.length}");
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    throw Exception('Error fetching posts: $e');
  }
}

}
