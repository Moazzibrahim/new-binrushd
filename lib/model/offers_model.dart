class OffersResponse {
  final String message;
  final OffersData data;

  OffersResponse({
    required this.message,
    required this.data,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) {
    return OffersResponse(
      message: json['message'],
      data: OffersData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class OffersData {
  final List<Offer> offers;
  final List<Campaign> campaigns;

  OffersData({
    required this.offers,
    required this.campaigns,
  });

  factory OffersData.fromJson(Map<String, dynamic> json) {
    return OffersData(
      offers: (json['offers'] as List)
          .map((item) => Offer.fromJson(item))
          .toList(),
      campaigns: (json['campaigns'] as List)
          .map((item) => Campaign.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offers': offers.map((e) => e.toJson()).toList(),
      'campaigns': campaigns.map((e) => e.toJson()).toList(),
    };
  }
}

class Offer {
  final int id;
  final String title;
  final String description;
  final String image;
  final int active;
  final int updatedBy;
  final String createdAt;
  final String updatedAt;
  final String startTime;
  final String endTime;
  final int isSlider;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.active,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.startTime,
    required this.endTime,
    required this.isSlider,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      active: json['active'],
      updatedBy: json['updated_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isSlider: json['isSlider'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'active': active,
      'updated_by': updatedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'startTime': startTime,
      'endTime': endTime,
      'isSlider': isSlider,
    };
  }
}

class Campaign {
  final int id;
  final String title;
  final String description;
  final String image;
  final String startTime;
  final String endTime;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final int isSlider;
  final int? updatedBy;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startTime,
    required this.endTime,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.isSlider,
    this.updatedBy,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      slug: json['slug'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isSlider: json['isSlider'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'startTime': startTime,
      'endTime': endTime,
      'slug': slug,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'isSlider': isSlider,
      'updated_by': updatedBy,
    };
  }
}
