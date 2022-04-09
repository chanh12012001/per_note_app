class Album {
  String? id;
  String? name;
  String? userId;

  Album({
    this.id,
    this.name,
    this.userId,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['_id'],
      name: json['name'],
      userId: json['userId'],
    );
  }
}
