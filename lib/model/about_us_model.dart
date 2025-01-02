class AboutUsModel {
  final String message;
  final BranchData data;

  AboutUsModel({
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      message: json['message'] ?? '',
      data: BranchData.fromJson(json['data'] ?? {}),
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class BranchData {
  final String description;
  final String email;
  final String facebookLink;
  final String twitterLink;
  final String instagramLink;
  final String tiktokLink;
  final String snapchatLink;
  final String linkedLink;
  final String youtubeLink;
  final String phoneNumber;
  final String whatsNumber;
  final String address;
  final String image;

  BranchData({
    required this.description,
    required this.email,
    required this.facebookLink,
    required this.twitterLink,
    required this.instagramLink,
    required this.tiktokLink,
    required this.snapchatLink,
    required this.linkedLink,
    required this.youtubeLink,
    required this.phoneNumber,
    required this.whatsNumber,
    required this.address,
    required this.image,
  });

  // Factory method to create an instance from JSON
  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      description: json['description'] ?? '',
      email: json['email'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      twitterLink: json['twitter_link'] ?? '',
      instagramLink: json['instagram_link'] ?? '',
      tiktokLink: json['tiktok_link'] ?? '',
      snapchatLink: json['snapchat_link'] ?? '',
      linkedLink: json['linked_link'] ?? '',
      youtubeLink: json['youtupe_link'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      whatsNumber: json['whats_number'] ?? '',
      address: json['address'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'email': email,
      'facebook_link': facebookLink,
      'twitter_link': twitterLink,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'snapchat_link': snapchatLink,
      'linked_link': linkedLink,
      'youtupe_link': youtubeLink,
      'phone_number': phoneNumber,
      'whats_number': whatsNumber,
      'address': address,
      'image': image,
    };
  }
}
