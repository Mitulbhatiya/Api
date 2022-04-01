class Post {
  final String message;
  // final int id;
  // final String title;
  // final String body;



  Post({

    required this.message,
    // required this.title,
    // required this.body,
    // required this.id,
  });

  factory Post.fromJson(Map<String,dynamic> json) {
    return Post(
        message: json['userID'],
      // title: json['title'],
      // body: json['body'],
      // id: json['id']

    );
  }
}
