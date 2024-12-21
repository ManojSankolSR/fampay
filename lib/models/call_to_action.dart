class CallToAction {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;
  final bool isCircular;
  final bool isSecondary;
  final int? strokeWidth;

  CallToAction({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
    required this.isCircular,
    required this.isSecondary,
    this.strokeWidth,
  });

  factory CallToAction.fromJson(Map<String, dynamic> json) {
    return CallToAction(
      text: json['text'],
      bgColor: json['bg_color'],
      textColor: json['text_color'],
      url: json['url'],
      isCircular: json['is_circular'] ?? false,
      isSecondary: json['is_secondary'] ?? false,
      strokeWidth: json['stroke_width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'bg_color': bgColor,
      'text_color': textColor,
      'url': url,
      'is_circular': isCircular,
      'is_secondary': isSecondary,
      'stroke_width': strokeWidth,
    };
  }
}
