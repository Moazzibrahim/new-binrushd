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
      data:
          (json['data'] as List).map((item) => Branch.fromJson(item)).toList(),
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

  @HiveField(9)
  final List<Doctor> doctors;

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
    required this.doctors,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      worktimes: WorkTimes.fromJson(json['worktimes']),
      email: json['email'],
      image: json['image'],
      doctors: (json['doctors'] as List)
          .map((item) => Doctor.fromJson(item))
          .toList(),
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

@HiveType(typeId: 3)
class Doctor extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String gender;

  @HiveField(3)
  final List<String> qualifications;

  @HiveField(4)
  final List<String> experience;

  @HiveField(5)
  final String speciality;

  @HiveField(6)
  final String degree;

  @HiveField(7)
  final String? phone;

  @HiveField(8)
  final String? email;

  @HiveField(9)
  final String brief;

  @HiveField(10)
  final String image;

  @HiveField(11)
  final int highlighted;

  Doctor({
    required this.id,
    this.name,
    required this.gender,
    required this.qualifications,
    required this.experience,
    required this.speciality,
    required this.degree,
    this.phone,
    this.email,
    required this.brief,
    required this.image,
    required this.highlighted,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'] ?? "",
      gender: json['Gender'] ?? '',
      qualifications: List<String>.from(json['qualifications'] ?? []),
      experience: List<String>.from(json['experience'] ?? []),
      speciality: json['Speciality'] ?? '',
      degree: json['Degree'] ?? '',
      phone: json['phone'],
      email: json['email'],
      brief: json['brief'] ?? '',
      image: json['image'] ?? '',
      highlighted: json['highligthed'] ?? 0,
    );
  }
}
