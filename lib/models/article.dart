class Article {
  final int id;
  // final int article_category_id;
  final String title;
  // final String content;
  final String image;
  // final DateTime created_at;
  // final DateTime updated_at;

  Article(
      {required this.id,
      // required this.article_category_id,
      required this.title,
      // required this.content,
      required this.image
      // required this.created_at,
      // required this.updated_at
      });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      // article_category_id: json['article_category_id'],
      title: json['title'],
      // content: json['content'],
      image: json['image'],
      // created_at: json['created_at'],
      // updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'article_category_id': article_category_id,
      'title': title,
      // 'content': content,
      'image': image,
      // 'created_at': created_at.toIso8601String(),
      // 'updated_at': updated_at.toIso8601String(),
    };
  }
}
