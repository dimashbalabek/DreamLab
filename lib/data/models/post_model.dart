class PostModel {
  final int id;
  final String slug;
  final String url;
  final String title;
  final String content;
  final String image;
  final String thumbnail;
  final String status;
  final String category;
  final String publishedAt;
  final String updatedAt;
  final int userId;

  PostModel({
    required this.id,
    required this.slug,
    required this.url,
    required this.title,
    required this.content,
    required this.image,
    required this.thumbnail,
    required this.status,
    required this.category,
    required this.publishedAt,
    required this.updatedAt,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      slug: json['slug'],
      url: json['url'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      thumbnail: json['thumbnail'],
      status: json['status'],
      category: json['category'],
      publishedAt: json['publishedAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
    );
  }
}
