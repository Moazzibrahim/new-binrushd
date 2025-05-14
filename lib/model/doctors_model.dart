class DoctorsResponse {
  final String message;
  final List<Doctors> data;

  DoctorsResponse({
    required this.message,
    required this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      message: json['message'],
      data: (json['data'] as List).map((e) => Doctors.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Doctors {
  final int id;
  final String fname;
  final String lname;
  final String gender;
  final List<String> qualifications;
  final List<String> experience;
  final String speciality;
  final String degree;
  final String? phone;
  final String? email;
  final String brief;
  final String image;
  final int highlighted;
  final List<Branches> branches;

  Doctors({
    required this.id,
    required this.fname,
    required this.lname,
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
    required this.branches,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      gender: json['Gender'],
      qualifications: List<String>.from(json['qualifications']),
      experience: List<String>.from(json['experience']),
      speciality: json['Speciality'],
      degree: json['Degree'],
      phone: json['phone'],
      email: json['email'],
      brief: json['brief'],
      image: json['image'],
      highlighted: json['highligthed'],
      branches:
          (json['branches'] as List).map((e) => Branches.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
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
      'branches': branches.map((e) => e.toJson()).toList(),
    };
  }
}

class Branches {
  final int id;
  final String name;
  final String brief;
  final String address;
  final double latitude;
  final double longitude;
  final WorkTimes worktimes;
  final String email;

  Branches({
    required this.id,
    required this.name,
    required this.brief,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.worktimes,
    required this.email,
  });

  factory Branches.fromJson(Map<String, dynamic> json) {
    return Branches(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      worktimes: WorkTimes.fromJson(json['worktimes']),
      email: json['email'],
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
    };
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
