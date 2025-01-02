class DoctorsResponse {
  final String message;
  final List<Doctor> data;

  DoctorsResponse({
    required this.message,
    required this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      message: json['message'],
      data: (json['data'] as List).map((e) => Doctor.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Doctor {
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

  Doctor({
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
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
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
    };
  }
}
