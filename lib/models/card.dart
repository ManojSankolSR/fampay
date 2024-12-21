import 'package:fampay/models/call_to_action.dart';

import 'package:fampay/models/card_image.dart';
import 'package:fampay/models/formatted_text.dart';
import 'package:fampay/models/gradient_data.dart';

class Card {
  final String id;
  final String name;
  final String slug;
  final String title;
  final FormattedText? formattedTitle;
  final String description;
  final FormattedText? formattedDescription;
  final CardImage? icon;
  final String? url;
  final CardImage? bgImage;
  final List<CallToAction>? cta;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;
  final int? iconSize;
   final String? bgColor;
     final GradientData? bgGradient;


  Card({
    required this.id,
    required this.name,
    required this.slug,
    required this.title,
    this.formattedTitle,
    required this.description,
    this.formattedDescription,
    this.icon,
    this.url,
    this.bgImage,
    required this.cta,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
    required this.iconSize,
     required this.bgColor,
     required this.bgGradient,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
      GradientData? gradient;
    if (json['bg_gradient'] != null) {
      gradient = GradientData.fromJson(json['bg_gradient']);
    }
    return Card(
      id: json['id'].toString(),
      name: json['name'],
      slug: json['slug'],
      title: json['title'] ?? '',
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      description: json['description'] ?? '',
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
      url: json['url'],
      bgImage: json['bg_image'] != null ? CardImage.fromJson(json['bg_image']) : null,
      cta: json['cta'] != null
          ? (json['cta'] as List).map((e) => CallToAction.fromJson(e)).toList()
          : null,  // Handle null case for CTA
      isDisabled: json['is_disabled'] ?? false,
      isShareable: json['is_shareable'] ?? false,
      isInternal: json['is_internal'] ?? false,
      iconSize: json['icon_size'],
      bgColor: json['bg_color'],
      bgGradient: gradient,

    );

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'title': title,
      'formatted_title': formattedTitle?.toJson(),
      'description': description,
      'formatted_description': formattedDescription?.toJson(),
      'icon': icon?.toJson(),
      'url': url,
      'bg_image': bgImage?.toJson(),
      'cta': cta?.map((e) => e.toJson()).toList(),
      'is_disabled': isDisabled,
      'is_shareable': isShareable,
      'is_internal': isInternal,

    };
  }
}
