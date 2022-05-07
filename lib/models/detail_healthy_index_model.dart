class DetailHealthyIndex {
  String? createAtDate;
  String? createAtTime;
  String? indexValue;
  String? healthyIndexId;
  String? userId;
  String? id;

  DetailHealthyIndex(
      {this.createAtDate,
      this.createAtTime,
      this.indexValue,
      this.healthyIndexId,
      this.userId,
      this.id});

  DetailHealthyIndex.fromJson(Map<String, dynamic> json) {
    createAtDate = json['createAtDate'];
    createAtTime = json['createAtTime'];
    indexValue = json['indexValue'];
    healthyIndexId = json['healthyIndexId'];
    userId = json['userId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createAtDate'] = createAtDate;
    data['createAtTime'] = createAtTime;
    data['indexValue'] = indexValue;
    data['healthyIndexId'] = healthyIndexId;
    data['userId'] = userId;
    data['id'] = id;
    return data;
  }
}
