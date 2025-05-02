import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../models/article_model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  final box = GetStorage();

  Future<Article> getArticles() async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.ARTICLE_ENDPOINT}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<ArticleElement> getArticleDetail(int id) async {
    final token = box.read('token');
    
    final response = await http.get(
      Uri.parse('${Constants.BASE_URL}${Constants.ARTICLE_DETAIL_ENDPOINT}$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ArticleElement.fromJson(jsonDecode(response.body)['article']);
    } else {
      throw Exception('Failed to load article detail');
    }
  }
}