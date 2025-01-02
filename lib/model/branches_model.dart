class BranchResponse {
  final String message;
  final List<Branch> data;

  BranchResponse({required this.message, required this.data});

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      message: json['message'],
      data:
          (json['data'] as List).map((item) => Branch.fromJson(item)).toList(),
    );
  }
}

class Branch {
  final int id;
  final String name;
  final String brief;
  final String address;
  final double latitude;
  final double longitude;
  final WorkTimes worktimes;
  final String email;
  final String image;

  Branch({
    required this.id,
    required this.name,
    required this.brief,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.worktimes,
    required this.email,
    required this.image,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      worktimes: WorkTimes.fromJson(json['worktimes']),
      email: json['email'],
      image: json['image'],
    );
  }
}

class WorkTimes {
  final String sunday;
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;

  WorkTimes({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory WorkTimes.fromJson(Map<String, dynamic> json) {
    return WorkTimes(
      sunday: json['sunday'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
    );
  }
}
