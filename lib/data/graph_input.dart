class GraphInput {
  double weight;
  String date;
  GraphInput({this.weight, this.date});

  factory GraphInput.fromJson(Map<String, dynamic> json) {
    return GraphInput(weight: json['weight'], date: json['date']);
  }
}
