class Article {
  final List<ArticleElement> article;

  Article({
    required this.article,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      article: List<ArticleElement>.from(
        json["article"].map((x) => ArticleElement.fromJson(x)),
      ),
    );
  }
}

class ArticleElement {
  final int id;
  final dynamic image;
  final String author;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  ArticleElement({
    required this.id,
    required this.image,
    required this.author,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ArticleElement.fromJson(Map<String, dynamic> json) {
    return ArticleElement(
      id: json["id"],
      image: json["image"],
      author: json["author"],
      title: json["title"],
      content: json["content"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }
}
