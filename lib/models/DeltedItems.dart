class DeletedItems {

  DeletedItems({
    required this.cardGroupId,
    required this.cardId,
  });

 
  factory DeletedItems.fromJson(Map<String, dynamic> json) {
    return DeletedItems(
      cardGroupId: json['cardGroupId'] as String,
      cardId: json['cardId'] as String,
    );
  }

  // Fields for cardGroupId and cardId

  final String cardGroupId;
  final String cardId;

  // Method to convert the object back into a JSON map
  Map<String, dynamic> toJson() => {
        'cardGroupId': cardGroupId,
        'cardId': cardId,
      };
}
