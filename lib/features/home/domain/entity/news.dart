class News {
  String author;
  String title;
  String description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String content;

  News(this.author, this.title, this.description, this.url, this.urlToImage,
      this.publishedAt, this.content);
}
