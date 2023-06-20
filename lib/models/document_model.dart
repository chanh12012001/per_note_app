class DocumentModel {
  String? createdAt;
  String? documentUrl;
  String? cloudinaryId;
  String? id;

  DocumentModel({
    this.createdAt,
    this.documentUrl,
    this.cloudinaryId,
    this.id,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    documentUrl = json['documentUrl'];
    cloudinaryId = json['cloudinaryId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAt'] = createdAt;
    data['documentUrl'] = documentUrl;
    data['cloudinaryId'] = cloudinaryId;
    data['id'] = id;
    return data;
  }
}
