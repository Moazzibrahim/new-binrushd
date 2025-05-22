class IndividualDoctorModel {
  final String? message;
  final DoctorData? data;

  IndividualDoctorModel({this.message, this.data});

  factory IndividualDoctorModel.fromJson(Map<String, dynamic> json) {
    return IndividualDoctorModel(
      message: json['message'] as String?,
      data: json['data'] != null && json['data'] is Map<String, dynamic>
          ? DoctorData.fromJson(json['data'])
          : null,
    );
  }
}


class DoctorData {
  final int? id;
  final String? fname;
  final String? lname;
  final String? gender;
  final List<String>? qualifications;
  final List<String>? experience;
  final String? speciality;
  final String? degree;
  final String? phone;
  final String? email;
  final String? brief;
  final String? image;
  final int? highlighted;
  final List<Branch>? branches;
  final List<Department>? departments;

  DoctorData({
    this.id,
    this.fname,
    this.lname,
    this.gender,
    this.qualifications,
    this.experience,
    this.speciality,
    this.degree,
    this.phone,
    this.email,
    this.brief,
    this.image,
    this.highlighted,
    this.branches,
    this.departments,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      id: json['id'] as int?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      gender: json['Gender'] as String?,
      qualifications: (json['qualifications'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      experience: (json['experience'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      speciality: json['Speciality'] as String?,
      degree: json['Degree'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      brief: json['brief'] as String?,
      image: json['image'] as String?,
      highlighted: json['highligthed'] as int?, // original typo preserved
      branches: (json['branches'] as List?)
          ?.map((branch) => Branch.fromJson(branch))
          .toList(),
      departments: (json['departments'] as List?)
          ?.map((dept) => Department.fromJson(dept))
          .toList(),
    );
  }
}

class Branch {
  final int? id;
  final String? name;
  final String? image;

  Branch({
    this.id,
    this.name,
    this.image,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }
}


class Department {
  final int? id;
  final String? name;
  final int? branchId;
  final String? image;

  Department({
    this.id,
    this.name,
    this.branchId,
    this.image,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as int?,
      name: json['name'] as String?,
      branchId: json['branch_id'] as int?,
      image: json['image'] as String?,
    );
  }
}

