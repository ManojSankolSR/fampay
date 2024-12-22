


import 'package:fampay/models/card_group.dart';

class SlugItem {
  final String id;
  final String? slug;
  final String? title;
  final String? formattedTitle;
  final String? description;
  final String? formattedDescription;
  final dynamic? assets;
  final List<CardGroup> cardGroups;

  SlugItem({
    required this.id,
    this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.cardGroups,
  });

  factory SlugItem.fromJson(Map<String, dynamic> json) {
    return SlugItem(
      id: json['id'].toString(),
      slug: json['slug'],
      title: json['title'],
      formattedTitle: json['formatted_title'],
      description: json['description'],
      formattedDescription: json['formatted_description'],
      assets: json['assets'],
      cardGroups: (json['hc_groups'] as List)
          .map((e) => CardGroup.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'formatted_title': formattedTitle,
      'description': description,
      'formatted_description': formattedDescription,
      'assets': assets,
      'hc_groups': cardGroups.map((e) => e.toJson()).toList(),
    };
  }

  SlugItem copyWith({List<CardGroup>? cardGroups}) {
    return SlugItem(
      id: this.id,  // Always the same as current instance, no need for parameter.
      slug: this.slug,
      title: this.title,
      formattedTitle: this.formattedTitle,
      description: this.description,
      formattedDescription: this.formattedDescription,
      assets: this.assets,
     cardGroups: cardGroups ?? this.cardGroups,
    );
  }
}
