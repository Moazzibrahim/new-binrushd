class DepartmentResponses {
  final String message;
  final DepartmentDatas data;

  DepartmentResponses({required this.message, required this.data});

  factory DepartmentResponses.fromJson(Map<String, dynamic> json) {
    return DepartmentResponses(
      message: json['message'],
      data: DepartmentDatas.fromJson(json['data']),
    );
  }
}

class DepartmentDatas {
  final int id;
  final String name;
  final String brief;
  final String image;
  final int branchId;
  final Branch branch;
  final List<Doctor> doctors;

  DepartmentDatas({
    required this.id,
    required this.name,
    required this.brief,
    required this.image,
    required this.branchId,
    required this.branch,
    required this.doctors,
  });

  factory DepartmentDatas.fromJson(Map<String, dynamic> json) {
    return DepartmentDatas(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      image: json['image'],
      branchId: json['branch_id'],
      branch: Branch.fromJson(json['branch']),
      doctors: (json['doctors']['data'] as List)
          .map((doctor) => Doctor.fromJson(doctor))
          .toList(),
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

class Doctor {
  final int id;
  final String fname;
  final String lname;
  final String speciality;
  final String? phone;
  final String? email;
  final String image;

  Doctor({
    required this.id,
    required this.fname,
    required this.lname,
    required this.speciality,
    this.phone,
    this.email,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      speciality: json['Speciality'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
    );
  }
}
