import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/article/article_controller.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatelessWidget {
  final controller = Get.find<ArticleController>();

  ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Article',
              style: TextStyle(
                  color: Color(0xFF151921),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.selectedArticle.value == null) {
          return Center(child: Text('Article not found'));
        } else {
          final article = controller.selectedArticle.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(article.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'By: ${article.author}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Spacer(),
                    Text(
                      DateFormat('dd MMM yyyy').format(article.createdAt),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
                Text(
                  article.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
