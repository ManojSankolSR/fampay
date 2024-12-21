class Entity {
  final String? text;
  final String type;
  final String? color;
  final String? fontStyle;
  final String? fontFamily;
  final int? fontSize;
  final String? url;

  Entity({
    required this.text,
    required this.type,
    required this.color,
    this.fontStyle,
    this.fontFamily,
    this.fontSize,
    this.url,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      text: json['text'],
      type: json['type'],
      color: json['color'],
      fontStyle: json['font_style'],
      fontFamily: json['font_family'],
      fontSize: json['font_size'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type,
      'color': color,
      'font_style': fontStyle,
      'font_family': fontFamily,
      'font_size': fontSize,
      'url': url,
    };
  }
}
