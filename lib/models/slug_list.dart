import 'package:fampay/models/card_group.dart';
import 'slug_item.dart'; // Ensure to import the SlugItem model

class SlugList {
  final List<SlugItem> responses;

  SlugList({required this.responses});

  factory SlugList.fromJson(List<dynamic> jsonList) {
    return SlugList(
      responses: jsonList.map((json) => SlugItem.fromJson(json)).toList(),
    );
  }

  List<dynamic> toJson() {
    return responses.map((response) => response.toJson()).toList();
  }

  SlugList copyWith({List<SlugItem>? responses}) {
    return SlugList(responses: responses ?? this.responses);
  }
}
