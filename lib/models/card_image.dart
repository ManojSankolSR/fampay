class CardImage {
  final String imageType;
  final String? imageUrl;
  final String? assetType;
  final double? aspectRatio;

  CardImage({
    required this.imageType,
    this.imageUrl,
    this.assetType,
    this.aspectRatio,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) {
    return CardImage(
      imageType: json['image_type'],
      imageUrl: json['image_url'],
      assetType: json['asset_type'],
      aspectRatio: json['aspect_ratio']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_type': imageType,
      'image_url': imageUrl,
      'asset_type': assetType,
      'aspect_ratio': aspectRatio,
    };
  }
}
