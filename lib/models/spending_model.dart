class Spending {
  String? id;
  String? kind;
  int? money;
  String? date;

  Spending({
    this.id,
    this.kind,
    this.money,
    this.date,
  });

  factory Spending.fromJson(Map<String, dynamic> json) {
    return Spending(
      id: json['_id'],
      kind: json['kind'],
      money: json['money'],
      date: json['date'],
    );
  }
}
