class ImageModel {
  String? createdAt;
  String? imageUrl;
  String? cloudinaryId;
  String? albumId;
  String? id;

  ImageModel({
    this.createdAt,
    this.imageUrl,
    this.cloudinaryId,
    this.albumId,
    this.id,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    imageUrl = json['imageUrl'];
    cloudinaryId = json['cloudinaryId'];
    albumId = json['albumId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;
    data['imageUrl'] = imageUrl;
    data['cloudinaryId'] = cloudinaryId;
    data['albumId'] = albumId;
    data['id'] = id;
    return data;
  }
}
