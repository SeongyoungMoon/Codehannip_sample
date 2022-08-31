class ConceptModel {
  int stage = 0;
  int step = 0;
  String documentId = "";
  String title;
  String description;

  ConceptModel(
      {this.stage,
      this.step,
      this.documentId,
      this.title,
      this.description,
      });

  factory ConceptModel.fromDs(dynamic ds, documentId) {
    return ConceptModel(
        stage: ds['stage'],
        step: ds['step'],
        title: ds['title'],
        description: ds['description'],
        documentId: documentId);
  }

  Map<String, dynamic> toMap() {
    return {
      'stage': stage,
      'step': step,
      'documentId': documentId,
      'title': title,
      'description': description
    };
  }
}
