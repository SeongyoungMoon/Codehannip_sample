class CodingCardModel {
  String type;
  String value;

  CodingCardModel({
    this.type,
    this.value,
  });

  factory CodingCardModel.fromDs(dynamic ds) {
    return CodingCardModel(
      type: ds['name'],
      value: ds['record'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': type,
      'record': value,
    };
  }
}