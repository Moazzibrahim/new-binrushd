class IndividualDoctorModel {
  final String message;
  final DoctorData data;

  IndividualDoctorModel({required this.message, required this.data});

  factory IndividualDoctorModel.fromJson(Map<String, dynamic> json) {
    return IndividualDoctorModel(
      message: json['message'],
      data: DoctorData.fromJson(json['data']),
    );
  }
}

class DoctorData {
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
  final List<Branch> branches;
  final List<Department> departments;

  DoctorData({
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
    required this.departments,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
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
      branches: (json['branches'] as List)
          .map((branch) => Branch.fromJson(branch))
          .toList(),
      departments: (json['departments'] as List)
          .map((dept) => Department.fromJson(dept))
          .toList(),
    );
  }
}

class Branch {
  final int id;
  final String name;
  final String image;

  Branch({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

class Department {
  final int id;
  final String name;
  final int branchId;
  final String image;

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
}
