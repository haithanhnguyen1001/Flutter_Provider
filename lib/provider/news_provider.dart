import 'package:flutter/material.dart';

import '../model/news.dart';
import '../repository/news_repository.dart';

class NewsProvider with ChangeNotifier {
  final NewsRepository _repository = NewsRepository();
  List<NewsModel> _newsList = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<NewsModel> get newsList => _newsList;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();
    try {
      _newsList = await _repository.fetchNews();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
