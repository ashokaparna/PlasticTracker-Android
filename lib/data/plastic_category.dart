class PlasticObject {
  final String category;
  final String subCategory;
  final int weight;
  final int count;
  final DateTime date;

  PlasticObject(
      {this.category, this.subCategory, this.weight, this.count, this.date});

  factory PlasticObject.fromJson(Map<String, dynamic> json) {
    return PlasticObject(
        category: json['category'],
        subCategory: json['subCategory'],
        weight: json['weight'],
        count: json['count'],
        date: json['date']);
  }
}
