
import 'package:fampay/models/entity.dart';

class FormattedText {
  final String text;
  final String align;
  final List<Entity> entities;

  FormattedText({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'],
      align: json['align'],
      entities: (json['entities'] as List)
          .map((e) => Entity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'align': align,
      'entities': entities.map((e) => e.toJson()).toList(),
    };
  }
}
