class OffersResponse {
  final String message;
  final List<Offer> data;

  OffersResponse({
    required this.message,
    required this.data,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) {
    return OffersResponse(
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((offer) => Offer.fromJson(offer as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((offer) => offer.toJson()).toList(),
    };
  }
}

class Offer {
  final String? image;

  Offer({
    this.image,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}
