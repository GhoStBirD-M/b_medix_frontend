import 'package:get/get.dart';
import '../services/article_service.dart';
import '../models/article_model.dart';

class ArticleController extends GetxController {
  final ArticleService _apiService = ArticleService();
  
  final RxList<ArticleElement> articles = <ArticleElement>[].obs;
  final Rx<ArticleElement?> selectedArticle = Rx<ArticleElement?>(null);
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }
  
  Future<void> fetchArticles() async {
    try {
      isLoading.value = true;
      final result = await _apiService.getArticles();
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
