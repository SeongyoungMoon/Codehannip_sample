class ColumnModel {
  Map cards;
  Map examples;
  int category;
  String description;

  ColumnModel({this.cards, this.examples, this.description, this.category,});

  factory ColumnModel.fromDs(dynamic ds, documentId) {
    return ColumnModel(
        cards: ds['cards'],
        examples: ds['examples'],
        category: ds['category'],
        description: ds['description']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cards': cards,
      'examples': examples,
      'category': category,
      'description': description
    };
  }
}
