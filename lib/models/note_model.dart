class Note {
  String? createdAt;
  String? title;
  String? content;
  String? imageUrl;
  String? cloudinaryId;
  String? userId;
  String? id;

  Note(
      {this.createdAt,
      this.title,
      this.content,
      this.imageUrl,
      this.cloudinaryId,
      this.userId,
      this.id});

  Note.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    title = json['title'];
    content = json['content'];
    imageUrl = json['imageUrl'];
    cloudinaryId = json['cloudinaryId'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['content'] = content;
    data['imageUrl'] = imageUrl;
    data['cloudinaryId'] = cloudinaryId;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}
