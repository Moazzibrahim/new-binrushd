class IndividualBranchModel {
  String message;
  BranchData data;

  IndividualBranchModel({required this.message, required this.data});

  factory IndividualBranchModel.fromJson(Map<String, dynamic> json) {
    return IndividualBranchModel(
      message: json['message'],
      data: BranchData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class BranchData {
  int id;
  String name;
  String brief;
  String address;
  double latitude;
  double longitude;
  WorkTimes worktimes;
  String email;
  String image;
  List<Department> departments;
  List<Doctor> doctors;

  BranchData({
    required this.id,
    required this.name,
    required this.brief,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.worktimes,
    required this.email,
    required this.image,
    required this.departments,
    required this.doctors,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      worktimes: WorkTimes.fromJson(json['worktimes']),
      email: json['email'],
      image: json['image'],
      departments: (json['departments'] as List)
          .map((e) => Department.fromJson(e))
          .toList(),
      doctors:
          (json['doctors'] as List).map((e) => Doctor.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brief': brief,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'worktimes': worktimes.toJson(),
      'email': email,
      'image': image,
      'departments': departments.map((e) => e.toJson()).toList(),
      'doctors': doctors.map((e) => e.toJson()).toList(),
    };
  }
}

class WorkTimes {
  String sunday;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;

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

  Map<String, dynamic> toJson() {
    return {
      'sunday': sunday,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
    };
  }
}

class Department {
  int id;
  String name;
  int branchId;
  String image;

  Department({
    required this.id,
    required this.name,
    required this.branchId,
    required this.image,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      branchId: json['branch_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch_id': branchId,
      'image': image,
    };
  }
}

class Doctor {
  int id;
  String? name;
  String? gender;
  String? qualifications;
  String? experience;
  String speciality;
  String? degree;
  String? phone;
  String? email;
  String? brief;
  String image;
  String? highlighted;

  Doctor({
    required this.id,
    this.name,
    this.gender,
    this.qualifications,
    this.experience,
    required this.speciality,
    this.degree,
    this.phone,
    this.email,
    this.brief,
    required this.image,
    this.highlighted,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      gender: json['Gender'],
      qualifications: json['qualifications'],
      experience: json['experience'],
      speciality: json['Speciality'],
      degree: json['Degree'],
      phone: json['phone'],
      email: json['email'],
      brief: json['brief'],
      image: json['image'],
      highlighted: json['highligthed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'Gender': gender,
      'qualifications': qualifications,
      'experience': experience,
      'Speciality': speciality,
      'Degree': degree,
      'phone': phone,
      'email': email,
      'brief': brief,
      'image': image,
      'highligthed': highlighted,
    };
  }
}
