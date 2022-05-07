class HealthyIndex {
  String? id;
  String? name;
  String? iconUrl;
  String? cloudinaryId;
  String? unit;

  HealthyIndex({
    this.id,
    this.name,
    this.iconUrl,
    this.cloudinaryId,
    this.unit,
  });

  HealthyIndex.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    iconUrl = json['iconUrl'];
    cloudinaryId = json['cloudinaryId'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['name'] = name;
    data['iconUrl'] = iconUrl;
    data['cloudinaryId'] = cloudinaryId;
    data['unit'] = unit;
    return data;
  }
}
