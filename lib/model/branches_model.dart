import 'package:hive/hive.dart';

part 'branches_model.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class BranchResponse extends HiveObject {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final List<Branch> data;

  BranchResponse({required this.message, required this.data});

  factory BranchResponse.fromJson(Map<String, dynamic> json) {
    return BranchResponse(
      message: json['message'],
      data: (json['data'] as List).map((item) => Branch.fromJson(item)).toList(),
    );
  }
}

@HiveType(typeId: 1)
class Branch extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String brief;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final double latitude;

  @HiveField(5)
  final double longitude;

  @HiveField(6)
  final WorkTimes worktimes;

  @HiveField(7)
  final String email;

  @HiveField(8)
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

@HiveType(typeId: 2)
class WorkTimes extends HiveObject {
  @HiveField(0)
  final String sunday;

  @HiveField(1)
  final String monday;

  @HiveField(2)
  final String tuesday;

  @HiveField(3)
  final String wednesday;

  @HiveField(4)
  final String thursday;

  @HiveField(5)
  final String friday;

  @HiveField(6)
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
