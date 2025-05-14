import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/widgets/article/article_card_shimmer.dart';
// import 'package:intl/intl.dart';
import '../widgets/article/article_card.dart';
import '../../views/widgets/common/search_bar.dart';
import '../../controllers/article_controller.dart';
// import '../../routes/app_pages.dart';
import '../widgets/common/bottom_navigation.dart';
// import 'dart:math';

class ArticleScreen extends StatelessWidget {
  final ArticleController controller = Get.put(ArticleController());

  ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles',
            style: TextStyle(
              color: Color(0xFF151921),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => const ArticleCardShimmer(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchArticles,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                CustomSearchBar(
                    hintText: 'Search Articles',
                    onChanged: controller.setSearchQuery),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    'Health News Articles',
                    style: TextStyle(
                      color: Color(0xFF151921),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (controller.articles.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(child: Text('No articles found')),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.articles.length,
                    itemBuilder: (context, index) {
                      final article = controller.articles[index];
                      return ArticleCard(
                          article: article, controller: controller);
                    },
                  ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: BottomNavigation(currentIndex: 2),
    );
  }
}
