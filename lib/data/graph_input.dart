class GraphInput {
  int weight;
  DateTime date;

  GraphInput({this.weight, this.date});

  setWeight(int w) {
    weight = w;
  }

  int getWeight() {
    return weight;
  }

  factory GraphInput.fromJson(Map<String, dynamic> json) {
    return GraphInput(weight: json['weight'], date: json['date']);
  }
}
