import 'package:fampay/models/card.dart';


class CardGroup {
  final String id;
  final String name;
  final String designType;
  final bool isScrollable;
  final int? height;
  final bool isFullWidth;
  final List<Card> cards;

  CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.isScrollable,
    required this.height,
    required this.isFullWidth,
    required this.cards,
  });

  CardGroup copyWith({List<Card>? updatedCards}) {
    return CardGroup(
      id: this.id,
      name: this.name,
      designType: this.designType,
      isScrollable: this.isScrollable,
      height: this.height,
      isFullWidth: this.isFullWidth,
      cards: updatedCards ?? this.cards,  
    );
  }

  factory CardGroup.fromJson(Map<String, dynamic> json) {
    return CardGroup(
      id: json['id'].toString(),
      name: json['name'],
      designType: json['design_type'],
      isScrollable: json['is_scrollable'],
      height: json['height'],
      isFullWidth: json['is_full_width'],
      cards: (json['cards'] as List)
          .map((e) => Card.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'design_type': designType,
      'is_scrollable': isScrollable,
      'height': height,
      'is_full_width': isFullWidth,
      'cards': cards.map((e) => e.toJson()).toList(),
    };
  }
}
