import 'article.dart';

class ArticlesResponse {
  final String status;
  final List<Article> articles;

  ArticlesResponse({
    required this.status,
    required this.articles,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    return ArticlesResponse(
      status: json['status'],
      articles: List<Article>.from(
        json['data']['articles'].map((x) => Article.fromJson(x)),
      ),
    );
  }
}
