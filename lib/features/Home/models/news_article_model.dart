class NewsArticleModel {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  NewsArticleModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      source: Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class Source {
  final String? id;
  final String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class NewsArticleModel {
//    final Source source;
//   final String? author;
//   final String title;
//   final String? description;
//   final String url;
//   final String? urlToImage;
//   final String publishedAt;
//   final String? content;
//    NewsArticleModel({
//     required this.source,
//     this.author,
//     required this.title,
//     this.description,
//     required this.url,
//     this.urlToImage,
//     required this.publishedAt,
//     this.content,
//   });
//   factory NewsArticleModel.fromJson(Map<String, dynamic> map) {
//     return NewsArticleModel(
//       author: map['author'],
//       title: map['title'],
//       description: map['description'],
//       url: map['url'],
//       urlToImage: map['urlToImage'],
//       publishedAt: map['publishedAt'],
//       content: map['content'], source: null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       author: 'author',
//       title: 'title',
//       description: 'description',
//       url: 'url',
//       urlToImage: 'urlToImage',
//       publishedAt: 'publishedAt',
//       content: 'content',
//     };
//   }
// }

// class Articles {
//   String? author;
//   String? title;
//   String? description;
//   String? url;
//   String? urlToImage;
//   String? publishedAt;
//   String? content;

//   Articles({
//     this.author,
//     this.title,
//     this.description,
//     this.url,
//     this.urlToImage,
//     this.publishedAt,
//     this.content,
//   });

//   Articles.fromJson(Map<String, dynamic> json) {
//     source = json['source'] != null
//         ? new Source.fromJson(json['source'])
//         : null;
//     author = json['author'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     urlToImage = json['urlToImage'];
//     publishedAt = json['publishedAt'];
//     content = json['content'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.source != null) {
//       data['source'] = this.source!.toJson();
//     }
//     data['author'] = this.author;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['url'] = this.url;
//     data['urlToImage'] = this.urlToImage;
//     data['publishedAt'] = this.publishedAt;
//     data['content'] = this.content;
//     return data;
//   }
// }
