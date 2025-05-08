import 'package:get/get.dart';
import '../services/article_service.dart';
import '../models/article_model.dart';

class ArticleController extends GetxController {
  final ArticleService _apiService = ArticleService();

  final RxBool isLoading = false.obs;
  final RxList<ArticleElement> allArticles = <ArticleElement>[].obs;
  final RxList<ArticleElement> articles = <ArticleElement>[].obs;
  final Rx<ArticleElement?> selectedArticle = Rx<ArticleElement?>(null);

  final RxString searchQuery  = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchArticles();

    debounce(searchQuery, (String query) {
      filterArticles(query);
    }, time: const Duration(milliseconds: 300));
  }

  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final result = await _apiService.getArticles();
      allArticles.value = result.article;
      articles.value = result.article;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterArticles(String query) {
    if (query.isEmpty) {
      articles.value = allArticles;
    } else {
      final lower = query.toLowerCase();
      articles.value = allArticles.where((article) {
        return article.title.toLowerCase().contains(lower) ||
            article.content.toLowerCase().contains(lower) ||
            article.author.toLowerCase().contains(lower);
      }).toList();
    }
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchArticleDetail(int id) async {
    try {
      isLoading.value = true;
      final result = await _apiService.getArticleDetail(id);
      selectedArticle.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
