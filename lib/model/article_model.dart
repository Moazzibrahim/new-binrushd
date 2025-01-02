class PostResponse {
  final String message;
  final List<Post> data;

  PostResponse({
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      message: json['message'],
      data: List<Post>.from(json['data'].map((post) => Post.fromJson(post))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((post) => post.toJson()).toList(),
    };
  }
}

class Post {
  final int id;
  final String title;
  final String content;
  final String image;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
    };
  }
}
