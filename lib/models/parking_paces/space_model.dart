class SpaceModel {
  bool available;
  int? number;
  String dateUpdated;
  String veichleDescription;
  String clientDescription;
  SpaceModel({
    this.number,
    required this.available,
    required this.clientDescription,
    required this.dateUpdated,
    required this.veichleDescription,
  });

  factory SpaceModel.fromMap(Map map) {
    return SpaceModel(
        number: map["number"],
        available: map["available"],
        clientDescription: map["clientDescription"],
        dateUpdated: map["dateUpdated"],
        veichleDescription: map["veichleDescription"]);
  }

  Map toMap() {
    return {
      "number": number,
      "available": available,
      "clientDescription": clientDescription,
      "dateUpdated": dateUpdated,
      "veichleDescription": veichleDescription,
    };
  }
}
