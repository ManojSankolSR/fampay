


import 'package:fampay/models/card_group.dart';

class ApiResponse {
  final int id;
  final String? slug;
  final String? title;
  final String? formattedTitle;
  final String? description;
  final String? formattedDescription;
  final dynamic? assets;
  final List<CardGroup> cardGroups;

  ApiResponse({
    required this.id,
    this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.cardGroups,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      id: json['id'],
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

  ApiResponse copyWith({List<CardGroup>? cardGroups}) {
    return ApiResponse(
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
