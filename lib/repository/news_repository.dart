import 'package:dio/dio.dart';

import '../model/news.dart';

class NewsRepository {
  final Dio _dio = Dio();
  final String _baseUrl = "https://newsapi.org/v2/everything";
  final String _apiKey = "5379e228bdc14de6b37c1bfb9c72dd22";

  Future<List<NewsModel>> fetchNews({String query = "tesla"}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          "q": query,
          "from": "2024-11-15",
          "sortBy": "publishedAt",
          "apiKey": _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articles = response.data["articles"];
        return articles.map((data) => NewsModel.fromMap(data)).toList();
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Error: $e");
    }
  }
}
